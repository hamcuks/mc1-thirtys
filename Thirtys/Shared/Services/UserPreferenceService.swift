//
//  UserPreferenceService.swift
//  Thirtys
//
//  Created by Ivan Nur Ilham Syah on 24/05/24.
//

import Foundation
import CoreData

class UserPreferenceService: ObservableObject {
    private let database: NSManagedObjectContext = PersistenceController.shared.container.viewContext
    
    static let shared: UserPreferenceService = UserPreferenceService()
    
    func storeWorkSchedules(items: [Weekday]) {
        items.forEach { day in
            let data = WorkScheduleEntity(context: database)
            data.day = day.label.rawValue
            data.startTime = day.event.startTime
            data.endTime = day.event.endTime
        }
        
        
        do {
            try database.save()
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    func getWorkSchedules() -> [WorkScheduleEntity] {
        let request: NSFetchRequest = NSFetchRequest<WorkScheduleEntity>(entityName: "WorkScheduleEntity")
        
        do {
            return try database.fetch(request)
        } catch {
            print("Error: \(error.localizedDescription)")
            
            return []
        }
    }
    
    func storeBedSchedule(bedTime: Event, wakeUpTime: Event) {
        let bedTime = BedTimeEntity(context: database)
        bedTime.label = bedTime.label
        bedTime.startTime = bedTime.startTime
        bedTime.endTime = bedTime.endTime
        
        let wakeUpTime = BedTimeEntity(context: database)
        wakeUpTime.label = wakeUpTime.label
        wakeUpTime.startTime = wakeUpTime.startTime
        wakeUpTime.endTime = wakeUpTime.endTime
        
        do {
            try database.save()
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    func getBedSchedules() -> [BedTimeEntity] {
        let request: NSFetchRequest = NSFetchRequest<BedTimeEntity>(entityName: "BedTimeEntity")
        
        do {
            return try database.fetch(request)
        } catch {
            print("Error: \(error.localizedDescription)")
            
            return []
        }
    }
}
