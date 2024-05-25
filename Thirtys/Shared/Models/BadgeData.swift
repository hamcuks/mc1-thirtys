//
//  BadgeData.swift
//  Thirtys
//
//  Created by Niko Febrianur on 22/05/24.
//

import Foundation

struct BadgeData: Hashable {
    var id: String
    var image: String
    var greeting: String
    var description: String
    var dayRule: Int
    
    static var items: [BadgeData] = [
        BadgeData(
            id: "first-learn",
            image: "1st-learning",
            greeting: "Congratulations! 🎉", 
            description: "You’ve completed your first learning session! You're off to a great start!",
            dayRule: 1
        ),
        BadgeData(
            id: "7-day-streak",
            image: "day-streak-7",
            greeting: "Congratulations! 🎉",
            description: "You’ve hit a 1-week streak! Keep up the great work!",
            dayRule: 7
        ),
        BadgeData(
            id: "14-day-streak",
            image: "day-streak-14",
            greeting: "Congratulations! 🎉",
            description: "You’ve hit a 2-week streak! Keep up the great work!",
            dayRule: 14
        ),
        BadgeData(
            id: "21-day-streak",
            image: "day-streak-21",
            greeting: "Congratulations! 🎉",
            description: "You’ve hit a 3-week streak! Keep up the great work!",
            dayRule: 21
        ),
        BadgeData(
            id: "1-month-streak",
            image: "month-1",
            greeting: "✨ Kudos! ✨",
            description: "You've consistently studied for 1 month. What an extraordinary achievement!",
            dayRule: 30
        ),
        BadgeData(
            id: "3-month-streak",
            image: "month-3",
            greeting: "✨ Kudos! ✨",
            description: "You've consistently studied for 3 months. What an extraordinary achievement!",
            dayRule: 90
        ),
        BadgeData(
            id: "6-month-streak",
            image: "month-6",
            greeting: "✨ Kudos! ✨",
            description: "You've consistently studied for 6 months. What an extraordinary achievement!",
            dayRule: 180
        ),
        BadgeData(
            id: "12-month-streak",
            image: "month-12",
            greeting: "✨ Kudos! ✨",
            description: "You've consistently studied for a full year. What an extraordinary achievement!",
            dayRule: 365
        )
    ]
    
    static func determineBadge(for day: Int) -> BadgeData? {
        self.items.first { $0.dayRule == day }
    }
    
    static func determineBadge(by id: String) -> BadgeData? {
        self.items.first { $0.id == id }
    }
}
