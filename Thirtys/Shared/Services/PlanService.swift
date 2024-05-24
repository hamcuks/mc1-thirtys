//
//  PlanService.swift
//  Thirtys
//
//  Created by Ivan Nur Ilham Syah on 24/05/24.
//

import Foundation
import CoreData

class PlanService: ObservableObject {
    private let database: NSManagedObjectContext = PersistenceController.shared.container.viewContext
    
    static let shared: PlanService = PlanService()
    
    func getAll() -> [PlanEntity] {
        let request: NSFetchRequest = NSFetchRequest<PlanEntity>(entityName: "PlanEntity")
        
        do {
            return try database.fetch(request)
        } catch {
            print("Error: \(error.localizedDescription)")
            
            return []
        }
    }
    
    func store(
        title: String,
        startDate: Date,
        duration: Int,
        learningTimes: [GrouppedWeekdayEvent]
    ) {
        let plan = PlanEntity(context: database)
        plan.title = title
        plan.startDate = startDate
        plan.duration = Int16(duration)
        
        
        var learningTimeEntities: [LearningTimeEntity] = []
        
        learningTimeEntities = learningTimes.flatMap { time in
            
            return time.events.map { event in
                let data = LearningTimeEntity(context: database)
                data.day = time.label.rawValue
                data.startTime = event.startTime
                data.endTime = event.endTime
                data.duration = Int16(event.duration ?? 0)
                
                return data
            }
            
        }
        
        plan.learningTimes = NSSet(array: learningTimeEntities)
        
        do {
            try database.save()
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
}
