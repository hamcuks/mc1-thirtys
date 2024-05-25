//
//  BadgeData.swift
//  Thirtys
//
//  Created by Niko Febrianur on 22/05/24.
//

import Foundation

struct BadgeData: Identifiable {
    var id: UUID = UUID()
    var image: String
    var greeting: String
    var description: String
    var isAchieved: Bool
    var dayRule: Int
    
    static var items: [BadgeData] = [
        BadgeData(image: "1st-learning", greeting: "Congratulations! 🎉", description: "You’ve completed your first learning session! You're off to a great start!", isAchieved: false, dayRule: 1),
        BadgeData(image: "day-streak-7", greeting: "Congratulations! 🎉", description: "You’ve hit a 1-week streak! Keep up the great work!", isAchieved: false, dayRule: 7),
        BadgeData(image: "day-streak-14", greeting: "Congratulations! 🎉", description: "You’ve hit a 2-week streak! Keep up the great work!", isAchieved: false, dayRule: 14),
        BadgeData(image: "day-streak-21", greeting: "Congratulations! 🎉", description: "You’ve hit a 3-week streak! Keep up the great work!", isAchieved: false, dayRule: 21),
        BadgeData(image: "month-1", greeting: "✨ Kudos! ✨", description: "You've consistently studied for 1 month. What an extraordinary achievement!", isAchieved: false, dayRule: 30),
        BadgeData(image: "month-3", greeting: "✨ Kudos! ✨", description: "You've consistently studied for 3 months. What an extraordinary achievement!", isAchieved: false, dayRule: 90),
        BadgeData(image: "month-6", greeting: "✨ Kudos! ✨", description: "You've consistently studied for 6 months. What an extraordinary achievement!", isAchieved: false, dayRule: 180),
        BadgeData(image: "month-12", greeting: "✨ Kudos! ✨", description: "You've consistently studied for a full year. What an extraordinary achievement!", isAchieved: false, dayRule: 365)
    ]
    
    static func determineBadge(for day: Int) -> BadgeData? {
        self.items.first { $0.dayRule == day }
    }
}
