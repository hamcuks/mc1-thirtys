//
//  Event.swift
//  Thirtys
//
//  Created by Ivan Nur Ilham Syah on 21/05/24.
//

import Foundation

struct Event: Hashable {
    var label: String
    var startTime: Date
    var endTime: Date
    var duration: Int?
}

struct GrouppedWeekdayEvent: Identifiable {
    var id: UUID = UUID()
    var label: WeekdayType
    var events: [Event]
}
