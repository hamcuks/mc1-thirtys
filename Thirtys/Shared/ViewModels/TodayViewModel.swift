//
//  TodayViewModel.swift
//  Thirtys
//
//  Created by Ivan Nur Ilham Syah on 23/05/24.
//

import Foundation
import CoreData

class TodayViewModel: ObservableObject {
    var database: PersistenceController = PersistenceController.shared
    
    @Published var plan: PlanEntity? = nil
    @Published var learningTimes: [GrouppedWeekdayEvent] = []
    @Published var currentLearningTime: Event? = nil
    
    func getPlanData() {
        // Create NSFetchRequest from PlanEntity
        let request = NSFetchRequest<PlanEntity>(entityName: "PlanEntity")
        
        do {
            // Get list of data based on NSFetchRequest
            let plans = try database.container.viewContext.fetch(request)
            
            // Select last plan data
            if let plan = plans.last {
                self.plan = plan
                
                print(plan)
            }
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    func getTodayLearningPlan() {
        let today = Calendar.current.dateComponents([.weekday, .day, .month], from: .now)
        
        if let plan = self.plan, let weekday = today.weekday {
            let learningTimes = plan.learningTimes?.allObjects as? Array<LearningTimeEntity> ?? []
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
    
    // Check if the current time is within the learning time range
    var isWithinLearningTimeRange: Bool {
        guard let currentLearningTime = currentLearningTime else { return false }
        return currentLearningTime.startTime <= .now && currentLearningTime.endTime >= .now
    }
    
}
