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
    
    func getBadges(planId: UUID) -> [BadgeData] {
        return []
    }
    
    func getLearningStreaks(plan: PlanEntity) -> [StreakEntity] {
        // TODO: get learning strike by plan id
        let items = plan.streaks?.allObjects as? Array<StreakEntity> ?? []
        
        return items
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
    
    func collectBadge(plan: PlanEntity, badge: BadgeData) {
        let updatePlan = plan
        
        let collectedBadge = BadgeEntity(context: database)
        collectedBadge.id = badge.id
        collectedBadge.collectedDate = .now
        
        updatePlan.badges = NSSet(array: [collectedBadge])
        
        do {
            try database.save()
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
}
