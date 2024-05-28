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
        endDate: Date
    ) {
        let plan = PlanEntity(context: database)
        plan.title = title
        plan.startDate = startDate
        plan.duration = Int16(duration)
        plan.endDate = endDate
        
        do {
            try database.save()
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
}
