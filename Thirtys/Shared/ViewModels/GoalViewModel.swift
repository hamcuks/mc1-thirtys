//
//  GoalViewModel.swift
//  Thirtys
//
//  Created by Bayu Septyan Nur Hidayat on 21/05/24.
//

import Foundation
import SwiftUI
import CoreData

class GoalViewModel: ObservableObject {
    private let planService: PlanService = PlanService.shared
    private let userPrefService: UserPreferenceService = UserPreferenceService.shared
    
    @Published var plan: PlanEntity? = nil
    @Published var learningTimes: [GrouppedWeekdayEvent] = []
    
    func getPlanData() {
        self.plan = planService.getAll().last
    }
    
    func getLearningTimes() {
        
        // Convert learningTimes object to Array
        let items = userPrefService.getLearningTimes()
        
        
        // Get the learning time weekday
        let weekday: [Int16] = Set(items.map { $0.day }).sorted()
        
        // Create GrouppedWeekdayEvent based on weekday data
        self.learningTimes = weekday.map { day in
            let events = items.filter { $0.day == day }
                
            return GrouppedWeekdayEvent(
                label: WeekdayType(rawValue: day)!,
                events: events.map {
                    Event(
                        label: "Learning Time",
                        startTime: $0.startTime!,
                        endTime: $0.endTime!
                    )
                }.sorted {
                    return $0.startTime.compare($1.startTime) == .orderedAscending
                }
            )
        }
    }
    
}
