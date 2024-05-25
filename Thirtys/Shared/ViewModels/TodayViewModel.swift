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
    var countdownInterval: TimeInterval = 10
    @Published var remainingTime: TimeInterval = 10 // 30 minutes in seconds
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
    
    func getPlanData() {
        if let plan = planService.getAll().last {
            self.plan = plan
        }
    }
    
    func getTodayLearningPlan() {
        let today = Calendar.current.dateComponents([.weekday, .day, .month], from: .now)
        
        if let weekday = today.weekday {
            let learningTimes = userPrefService.getLearningTimes()
            let todayLearningTimes = learningTimes.filter { entity in entity.day == weekday }
            
            todayLearningTimes.enumerated().forEach { index, current in
                if let next = learningTimes[safe: index + 1] {
                    if current.startTime! >= .now && .now <= current.endTime! {
                        self.currentLearningTime = Event(
                            label: "Current Event Time",
                            startTime: current.startTime!,
                            endTime: current.endTime!,
                            duration: Int(current.duration)
                        )
                    } else {
                        self.currentLearningTime = Event(
                            label: "Current Event Time",
                            startTime: next.startTime!,
                            endTime: next.endTime!,
                            duration: Int(next.duration)
                        )
                    }
                }
            }
        }
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
    }
    
    func pauseTimer() {
        isTimerActive = false
        timer?.cancel()
        recordSession()
    }
    
    func resetTimer() {
        remainingTime = self.countdownInterval
        isTimerActive = false
        hasStarted = false
        timer?.cancel()
        startTime = nil
        learningHistory.removeAll()
    }
    
    func completeSession() {
        isTimerActive = false
        timer?.cancel()
        recordSession()
        self.todayLearningHasCompleted = true
        self.updateDailyStreak()
        self.getAchievement()
    }
    
    func recordSession() {
        if let start = startTime {
            let endTime = Date()
            let session = Event(
                label: "Learning History",
                startTime: start,
                endTime: endTime,
                duration: Int(self.countdownInterval - remainingTime)
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
                let items = streakService.getLearningStreaks(plan: plan)
                
                self.learningStreaks = items
                self.dailyStreak = items.count
            }
        }
    }
    
    func checkTodayLearningState() {
        self.todayLearningHasCompleted = self.learningStreaks.contains(where: {
            Calendar.current.isDate($0.date!, equalTo: .now, toGranularity: .day)
        })
    }
    
    func getAchievement() {
        if let plan = self.plan, let badge = BadgeData.determineBadge(for: dailyStreak) {
            self.badgeData = badge
            
            withAnimation(.easeIn) {
                self.showBadge = true
            }
            
            streakService.collectBadge(plan: plan, badge: badge)
        }
    }
}
