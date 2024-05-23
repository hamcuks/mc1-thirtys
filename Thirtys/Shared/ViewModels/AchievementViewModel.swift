//
//  BadgeViewModel.swift
//  Thirtys
//
//  Created by Bayu Septyan Nur Hidayat on 22/05/24.
//

import Foundation

import Foundation

class AchievementViewModel: ObservableObject {
    
    @Published var imageTitle: String = ""
    @Published var descBadge: String = ""
    @Published var titleBadge: String = ""
    @Published var dailyStrike: Int = 6
    
    func getAchievement() -> Bool {
        guard let badge = determineBadge(for: dailyStrike) else {
            return false
        }
        imageTitle = badge.image
        descBadge = badge.description
        titleBadge = badge.greeting
        BadgeData.updateAchievement(for: dailyStrike)
        return true
    }
    
    func determineBadge(for streak: Int) -> BadgeData? {
        guard let image = BadgeData.determineImage(for: streak) else {
            return nil
        }
        return BadgeData.items.first { $0.image == image }
    }
    
    func updateDailyStreak() {
        dailyStrike += 1
    }
}
