//
//  OnboardingViewModel.swift
//  Thirtys
//
//  Created by Ivan Nur Ilham Syah on 21/05/24.
//

import Foundation

class OnboardingViewModel: ObservableObject {
    // Learning Time
    @Published var learningTimes: [GrouppedWeekdayEvent] = []
    
    // Step One
    @Published var planTitle: String = ""
    @Published var planStartDate: Date = .now
    @Published var planDuration: Int = 1
    
    // Step Two
    @Published var weekDays: [Weekday] = [
        Weekday(label: .sunday),
        Weekday(label: .monday),
        Weekday(label: .tuesday),
        Weekday(label: .wednesday),
        Weekday(label: .thursday),
        Weekday(label: .friday),
        Weekday(label: .saturday)
    ]
    
    // Step Three
    @Published var bedTime: Event = Event(
        label: "Bed Time",
        startTime: Calendar.current.date(bySettingHour: 22, minute: 30, second: 0, of: Date())!,
        endTime: Calendar.current.date(bySettingHour: 23, minute: 59, second: 0, of: Date())!
    )
    @Published var wakeUpTime: Event = Event(
        label: "Wake Up Time",
        startTime: Calendar.current.date(bySettingHour: 00, minute: 00, second: 0, of: Date())!,
        endTime: Calendar.current.date(bySettingHour: 04, minute: 30, second: 0, of: Date())!
    )
    
    private func makeGrouppedEvent() -> [GrouppedWeekdayEvent] {
        return self.weekDays.map { day in
            GrouppedWeekdayEvent(
                label: day.label,
                events: [
                    self.wakeUpTime,
                    day.event,
                    self.bedTime,
                ]
            )
        }
    }
    
    private func findFreeTime(grouppedEvents: [GrouppedWeekdayEvent]) -> [GrouppedWeekdayEvent] {
        return grouppedEvents.map { group in
            
            let freeTime = group.events.enumerated().compactMap {
                (index, current) in
                
                if let next = group.events[safe: index + 1] {
                    let startTime = current.endTime.addMinute(to: 1)
                    
                    let endTime = next.startTime.addMinute(to: -1)
                    
                    let diff = Calendar.current.dateComponents([.minute], from: startTime, to: endTime).minute ?? 0
                    
                    // Only get the learning time if greater and or equals with 30 minute
                    if diff >= 30 {
                        return Event(
                            label: "Free Time",
                            startTime: startTime,
                            endTime: endTime,
                            duration: diff
                        )
                    }
                }
                
                return nil
            }
            
            return GrouppedWeekdayEvent(
                label: group.label,
                events: freeTime
            )
            
        }
    }
    
    func getLearningTime() {
        let grouppedEvents: [GrouppedWeekdayEvent] = makeGrouppedEvent()
        self.learningTimes = self.findFreeTime(
            grouppedEvents: grouppedEvents
        )
        
        print(self.learningTimes)
    }
}

