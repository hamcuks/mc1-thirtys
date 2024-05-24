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
        let bedTimeEntity = BedTimeEntity(context: database)
        bedTimeEntity.label = bedTime.label
        bedTimeEntity.startTime = bedTime.startTime
        bedTimeEntity.endTime = bedTime.endTime
        
        let wakeUpTimeEntity = BedTimeEntity(context: database)
        wakeUpTimeEntity.label = wakeUpTime.label
        wakeUpTimeEntity.startTime = wakeUpTime.startTime
        wakeUpTimeEntity.endTime = wakeUpTime.endTime
        
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
    
    func storeLearningTime(items: [GrouppedWeekdayEvent]) {
        items.forEach { time in
            time.events.forEach { event in
                let data = LearningTimeEntity(context: database)
                data.day = time.label.rawValue
                data.startTime = event.startTime
                data.endTime = event.endTime
                data.duration = Int16(event.duration ?? 0)
            }
        }
        
        do {
            try database.save()
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    func getLearningTimes() -> [LearningTimeEntity] {
        let request: NSFetchRequest = NSFetchRequest<LearningTimeEntity>(entityName: "LearningTimeEntity")
        
        do {
            let items = try database.fetch(request)
            
            return items
        } catch {
            print("Error: \(error.localizedDescription)")
            
            return []
        }
    }
}


