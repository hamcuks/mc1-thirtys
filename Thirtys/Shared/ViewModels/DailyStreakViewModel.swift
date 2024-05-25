//
//  DailyStreakViewModel.swift
//  Thirtys
//
//  Created by Ivan Nur Ilham Syah on 25/05/24.
//

import Foundation

class DailyStreakViewModel: ObservableObject {
    private let planService: PlanService = PlanService.shared
    private let streakService: StreakService = StreakService.shared
    
    @Published var plan: PlanEntity? = nil
    @Published var streaks: [StreakEntity] = []
    @Published var badges: [BadgeEntity] = []
    
    func getPlan() {
        self.plan = planService.getAll().last
    }
    
    func getLearningStreaks() {
        if let plan = self.plan {
            self.streaks = streakService.getLearningStreaks(planId: plan.objectID)
        }
    }
    
    func getBadges() {
        self.badges = streakService.getBadges()
    }
    
    func isAchieved(badge: BadgeData) -> Bool {
        print(self.badges)
        return self.badges.contains(where: { $0.id == badge.id })
    }
}
