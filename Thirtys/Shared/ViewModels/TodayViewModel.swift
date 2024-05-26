//
//  TodayViewModel.swift
//  Thirtys
//
//  Created by Ivan Nur Ilham Syah on 23/05/24.
//

import Foundation
import CoreData
import Combine
import SwiftUI
import ActivityKit

class TodayViewModel: ObservableObject {
    var database: PersistenceController = PersistenceController.shared
    
    private let planService: PlanService = PlanService.shared
    private let userPrefService: UserPreferenceService = UserPreferenceService.shared
    private let streakService: StreakService = StreakService.shared
    
    // Plan Data
    @Published var plan: PlanEntity? = nil
    @Published var learningTimes: [GrouppedWeekdayEvent] = []
    @Published var currentLearningTime: Event? = nil
    
    // Countdown Data
    var countdownInterval: TimeInterval = 30
    @Published var remainingTime: TimeInterval = 30 // 30 minutes in seconds
    @Published var isTimerActive: Bool = false
    @Published var hasStarted: Bool = false
    private var timer: AnyCancellable?
    private var startTime: Date?
    
    // User Learning Data
    @Published var learningHistory: [Event] = []
    @Published var todayLearningHasCompleted: Bool = false
    
    @Published var dailyStreak: Int = 0
    @Published var learningStreaks: [StreakEntity] = []
    @Published var showBadge: Bool = false
    @Published var badgeData: BadgeData? = nil
    
    // This Week Streak
    @Published var weekdays: [Date] = []
    @Published var weeklyStreaks: [Date] = []
    
    private var activity: Activity<LearningTimerAttributes>? = nil
    
    init() {
        self.getWeekday()
    }
    
    func getPlanData() {
        if let plan = planService.getAll().last {
            self.plan = plan
        }
    }
    
    func getTodayLearningPlan() {
        let today = Calendar.current.dateComponents([.weekday, .day, .month], from: .now)
        
        if let weekday = today.weekday {
            let learningTimes = userPrefService.getLearningTimes()
            let todayLearningTimes = learningTimes.filter { entity in entity.day == weekday - 1 }
            
            todayLearningTimes.enumerated().forEach { index, current in
                
                if current.startTime! <= .now && .now <= current.endTime! || current.startTime! >= .now && .now <= current.endTime! {
                    self.currentLearningTime = Event(
                        label: "Current Event Time",
                        startTime: current.startTime!,
                        endTime: current.endTime!,
                        duration: Int(current.duration)
                    )
                }
            }
        }
        
        
    }
    
    func getWeekday() {
        let calendar = Calendar.current
        
        let now = Date()
        
        let weekday = calendar.component(.weekday, from: now)
        let startOfWeek = calendar.date(byAdding: .day, value: -(weekday - calendar.firstWeekday), to: now)!
        
        var weekDates: [Date] = []
        for i in 0..<7 {
            
            if let date = calendar.date(byAdding: .day, value: i, to: startOfWeek) {
                weekDates.append(date)
            }
        }
        
        self.weekdays = weekDates
        print(weekDates)
    }
    
    func startTimer() {
        isTimerActive = true
        hasStarted = true
        startTime = Date() // Record the start time
        timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect().sink { _ in
            withAnimation(.linear) {
                self.remainingTime -= 1
                if self.remainingTime <= 0 {
                    self.completeSession()
                }
            }
        }
        
        Task {
            if self.remainingTime == self.countdownInterval {
                await self.startLiveActivity()
            } else {
                await self.resumeLiveActivity()
            }
        }
    }
    
    func startLiveActivity() async {
        let attributes = LearningTimerAttributes(countdownInterval: countdownInterval)
        let state = LearningTimerAttributes.ContentState(
            startDate: self.startTime ?? .now,
            timer: (self.startTime ?? .now).addingTimeInterval(countdownInterval)
        )
        
        let activityContent = ActivityContent(
            state: state,
            staleDate: nil
        )
        
        do {
            self.activity = try Activity<LearningTimerAttributes>.request(
                attributes: attributes,
                content: activityContent,
                pushType: nil
            )
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    func pauseLiveActivity() async {
        let pause = Date.now.addingTimeInterval(self.remainingTime)

        let state = LearningTimerAttributes.ContentState(
            startDate: .now,
            pauseDate: pause,
            timer: pause
        )
        
        let activityContent = ActivityContent(
            state: state,
            staleDate: nil
        )
        
        await self.activity?.update(activityContent)
    }
    
    func resumeLiveActivity() async {
        let timer = Date.now.addingTimeInterval(self.remainingTime)
        
        let state = LearningTimerAttributes.ContentState(
            startDate: .now,
            timer: timer
        )
        
        let activityContent = ActivityContent(
            state: state,
            staleDate: nil
        )
        
        await self.activity?.update(activityContent)
    }
    
    func stopLiveActivity() async {
        let state = LearningTimerAttributes.ContentState(
            startDate: self.startTime ?? .now,
            timer: (self.startTime ?? .now).addingTimeInterval(countdownInterval)
        )
        
        let activityContent = ActivityContent(
            state: state,
            staleDate: nil
        )
        
        await self.activity?.end(activityContent, dismissalPolicy:.immediate)
    }
    
    func pauseTimer() {
        isTimerActive = false
        timer?.cancel()
        recordSession()
        Task {
            await self.pauseLiveActivity()
        }
    }
    
    func resetTimer() {
        remainingTime = self.countdownInterval
        isTimerActive = false
        hasStarted = false
        timer?.cancel()
        startTime = nil
        learningHistory.removeAll()
        
        Task {
            await self.stopLiveActivity()
        }
    }
    
    func completeSession() {
        isTimerActive = false
        timer?.cancel()
        recordSession()
        self.todayLearningHasCompleted = true
        self.updateDailyStreak()
        self.getLearningStreaks()
        self.getAchievement()
        
        Task {
            await self.stopLiveActivity()
        }
    }
    
    func recordSession() {
        if let start = startTime {
            let endTime = Date()
            let session = Event(
                label: "Learning History",
                startTime: start,
                endTime: endTime,
                duration: Calendar.current.dateComponents([.second], from: start, to: endTime).second ?? 0
            )
            learningHistory.append(session)
        }
    }
    
    var isWithinLearningTime: Bool {
        guard let currentLearningTime = currentLearningTime else { return false }
        return currentLearningTime.startTime <= .now && currentLearningTime.endTime >= .now
    }
    
    func updateDailyStreak() {
        if let plan = self.plan {
            streakService.updateDailyStreak(plan: plan, learningHistory: self.learningHistory)
            
            self.getLearningStreaks()
        }
    }
    
    func getLearningStreaks() {
        if let plan = self.plan {
            withAnimation {
                let items = streakService.getLearningStreaks(planId: plan.objectID)
                
                self.learningStreaks = items
                self.dailyStreak = items.count
            }
            
            print("Weekdays: \(self.weekdays)")
            
            if !self.weekdays.isEmpty {
                self.weeklyStreaks = streakService.getLearningStreaks(
                    planId: plan.objectID,
                    from: self.weekdays.first!,
                    to: self.weekdays.last!
                ).map { $0.date! }
            }
        }
    }
    
    func checkTodayLearningState() {
        
        // Get today learning history. If exist, it means the user
        // has completed today learning session
        guard let history = self.learningStreaks.first(where: {
            Calendar.current.isDate($0.date!, equalTo: .now, toGranularity: .day)
        }) else {
            
            // Otherwise, user has not complete the learning session
            self.todayLearningHasCompleted = false
            return
        }
        
        self.todayLearningHasCompleted = true
        
        // Transform array of LearningHistoryEntity into array of Event
        self.learningHistory = (history.history?.allObjects as? Array<LearningHistoryEntity> ?? []).compactMap {
            if let startTime = $0.startTime, let endTime = $0.endTime {
                return Event(
                    label: "Learning History",
                    startTime: startTime,
                    endTime: endTime,
                    duration: Calendar.current.dateComponents([.second], from: startTime, to: endTime).second ?? 0
                )
            }
            
            return nil
        }
    }
    
    func getAchievement() {
        if let badge = BadgeData.determineBadge(for: dailyStreak) {
            self.badgeData = badge
            
            withAnimation(.easeIn) {
                self.showBadge = true
            }
            
            streakService.collectBadge(badge: badge)
        }
    }
    
    func checkDailyStreakChecked(by date: Date) -> Bool {
        let result = self.weeklyStreaks.contains(where: {
            return Calendar.current.isDate($0, equalTo: date, toGranularity: .day)
        })
        
        return result
    }
}
