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
    
    static var items: [BadgeData] = [
        BadgeData(image: "1st-learning", greeting: "Congratulations! 🎉", description: "You’ve completed your first learning session! You're off to a great start!", isAchieved: false),
        BadgeData(image: "day-streak-7", greeting: "Congratulations! 🎉", description: "You’ve hit a 1-week streak! Keep up the great work!", isAchieved: false),
        BadgeData(image: "day-streak-14", greeting: "Congratulations! 🎉", description: "You’ve hit a 2-week streak! Keep up the great work!", isAchieved: false),
        BadgeData(image: "day-streak-21", greeting: "Congratulations! 🎉", description: "You’ve hit a 3-week streak! Keep up the great work!", isAchieved: false),
        BadgeData(image: "month-1", greeting: "✨ Kudos! ✨", description: "You've consistently studied for 1 month. What an extraordinary achievement!", isAchieved: false),
        BadgeData(image: "month-3", greeting: "✨ Kudos! ✨", description: "You've consistently studied for 3 months. What an extraordinary achievement!", isAchieved: false),
        BadgeData(image: "month-6", greeting: "✨ Kudos! ✨", description: "You've consistently studied for 6 months. What an extraordinary achievement!", isAchieved: false),
        BadgeData(image: "month-12", greeting: "✨ Kudos! ✨", description: "You've consistently studied for a full year. What an extraordinary achievement!", isAchieved: false)
    ]
    
    static func updateAchievement(for streak: Int) {
        if let index = BadgeData.items.firstIndex(where: { $0.image == determineImage(for: streak) }) {
            BadgeData.items[index].isAchieved = true
        }
    }
    
    static func determineImage(for streak: Int) -> String? {
        switch streak {
        case 1:
            return "1st-learning"
        case 7:
            return "day-streak-7"
        case 14:
            return "day-streak-14"
        case 21:
            return "day-streak-21"
        case 30:
            return "month-1"
        case 90:
            return "month-3"
        case 180:
            return "month-6"
        case 365:
            return "month-12"
        default:
            return nil
        }
    }
}
