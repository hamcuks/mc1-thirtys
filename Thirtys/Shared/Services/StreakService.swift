//
//  StreakService.swift
//  Thirtys
//
//  Created by Ivan Nur Ilham Syah on 24/05/24.
//

import Foundation
import CoreData

class StreakService: ObservableObject {
    private let database: NSManagedObjectContext = PersistenceController.shared.container.viewContext
    static let shared: StreakService = StreakService()
    
    func getBadges() -> [BadgeEntity] {
        let request: NSFetchRequest = NSFetchRequest<BadgeEntity>(entityName: "BadgeEntity")
        
        do {
            let items = try database.fetch(request)
            
            return items
        } catch {
            print("Error: \(error.localizedDescription)")
            
            return []
        }
    }
    
    func getLearningStreaks(planId: NSManagedObjectID, from startDate: Date? = nil, to endDate: Date? = nil) -> [StreakEntity] {
        var predicate: NSPredicate? = nil
        
        if let start = startDate, let end = endDate {
            predicate = NSPredicate(
                format: "plan == %@ && date >= %@ && date <= %@",
                planId as NSManagedObjectID,
                start as NSDate,
                end as NSDate
            )
        } else {
            predicate = NSPredicate(format: "plan == %@", planId as NSManagedObjectID)
        }
        
        let request: NSFetchRequest = NSFetchRequest<StreakEntity>(entityName: "StreakEntity")
        request.predicate = predicate
        
        do {
            let items = try database.fetch(request)
            
            return items
        } catch {
            print("Error: \(error.localizedDescription)")
            
            return []
        }
    }
    
    func updateDailyStreak(plan: PlanEntity, learningHistory: [Event]) {
        let updatePlan = plan
        
        let streak = StreakEntity(context: database)
        streak.date = .now
        streak.history = NSSet(
            array: learningHistory.map { history in
                let learnHistory = LearningHistoryEntity(context: database)
                learnHistory.startTime = history.startTime
                learnHistory.endTime = history.endTime
                
                return learnHistory
            }
        )
        
        updatePlan.streaks = NSSet(array: [streak])
        
        do {
            try database.save()
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    func collectBadge(badge: BadgeData) {
        
        let collectedBadge = BadgeEntity(context: database)
        collectedBadge.id = badge.id
        collectedBadge.collectedDate = .now
        
        do {
            try database.save()
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
}
