//
//  Weekday.swift
//  Thirtys
//
//  Created by Ivan Nur Ilham Syah on 21/05/24.
//

import Foundation

struct Weekday: Identifiable {
    var id: UUID = UUID()
    var label: WeekdayType
    var event: Event = Event(
        label: "Work Schedules",
        startTime: Calendar.current.date(bySettingHour: 08, minute: 30, second: 0, of: Date())!,
        endTime: Calendar.current.date(bySettingHour: 17, minute: 30, second: 0, of: Date())!
    )
    var isDayOff: Bool = false
    var isEdited: Bool = false
    
    static var dummy: Weekday = Weekday(label: .sunday)
}
