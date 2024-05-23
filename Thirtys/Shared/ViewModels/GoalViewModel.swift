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
    var database: PersistenceController = PersistenceController.shared
    
    @Published var plan: PlanEntity? = nil
    @Published var learningTimes: [GrouppedWeekdayEvent] = []
    
    func getPlanData() {
        // Create NSFetchRequest from PlanEntity
        let request = NSFetchRequest<PlanEntity>(entityName: "PlanEntity")
        
        do {
            // Get list of data based on NSFetchRequest
            let plans = try database.container.viewContext.fetch(request)
            
            // Select last plan data
            if let plan = plans.last {
                self.plan = plan
                
                self.getLearningTimes()
            }
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    private func getLearningTimes() {
        
        // Convert learningTimes object to Array
        let items = (self.plan?.learningTimes?.allObjects as? Array<LearningTimeEntity> ?? [])
        
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
