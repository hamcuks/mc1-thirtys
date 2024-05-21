//
//  OnboardingViewModel.swift
//  Thirtys
//
//  Created by Ivan Nur Ilham Syah on 21/05/24.
//

import Foundation

struct Weekday: Identifiable {
    var id: UUID = UUID()
    var label: String
    var timeRange: [Date] = [
        .now,
        Calendar.current.date(byAdding: .hour, value: 8, to: .now)!
    ]
    var isDayOff: Bool = false
    var isEdited: Bool = false
    
    static var dummy: Weekday = Weekday(label: "Sunday")
}

class OnboardingViewModel: ObservableObject {
    // Step One
    @Published var planTitle: String = ""
    @Published var planStartDate: Date = .now
    @Published var planDuration: Int = 1
    
    // Step Two
    @Published var weekDays: [Weekday] = [
        Weekday(label: "Sunday"),
        Weekday(label: "Monday"),
        Weekday(label: "Tuesday"),
        Weekday(label: "Wednesday"),
        Weekday(label: "Thursday"),
        Weekday(label: "Friday"),
        Weekday(label: "Saturday")
    ]
    
    @Published var sundaySetup: Weekday = Weekday(label: "Sunday")
    @Published var mondaySetup: Weekday = Weekday(label: "Monday")
    @Published var wednesdaySetup: Weekday = Weekday(label: "Wednesday")
    @Published var thursdaySetup: Weekday = Weekday(label: "Thurday")
    @Published var fridaySetup: Weekday = Weekday(label: "Friday")
    @Published var saturdaySetup: Weekday = Weekday(label: "Saturday")
}
