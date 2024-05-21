//
//  WeekdayTypeEnum.swift
//  Thirtys
//
//  Created by Ivan Nur Ilham Syah on 21/05/24.
//

import Foundation

enum WeekdayType: String, CaseIterable {
    case sunday = "SUN"
    case monday = "MON"
    case tuesday = "TUE"
    case wednesday = "WED"
    case thursday = "THU"
    case friday = "FRI"
    case saturday = "SAT"
    
    var term: String {
        switch self {
        case .sunday:
            "Sunday"
        case .monday:
            "Monday"
        case .tuesday:
            "Tuesday"
        case .wednesday:
            "Wednesday"
        case .thursday:
            "Thursday"
        case .friday:
            "Friday"
        case .saturday:
            "Saturday"
        }
    }
}
