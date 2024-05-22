//
//  WeekdayTypeEnum.swift
//  Thirtys
//
//  Created by Ivan Nur Ilham Syah on 21/05/24.
//

import Foundation

@objc
enum WeekdayType: Int16, CaseIterable {
    case sunday
    case monday
    case tuesday
    case wednesday
    case thursday
    case friday
    case saturday
    
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
    
    var shortTerm: String {
        switch self {
        case .sunday:
            "SUN"
        case .monday:
            "MON"
        case .tuesday:
            "TUE"
        case .wednesday:
            "WED"
        case .thursday:
            "THU"
        case .friday:
            "FRI"
        case .saturday:
            "SAT"
        }
    }
}
