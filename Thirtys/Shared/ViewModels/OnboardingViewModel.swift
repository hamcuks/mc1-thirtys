//
//  OnboardingViewModel.swift
//  Thirtys
//
//  Created by Ivan Nur Ilham Syah on 21/05/24.
//

import Foundation
import CoreData

class OnboardingViewModel: ObservableObject {
    var database: PersistenceController = PersistenceController.shared
    
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
    
    private func storeWorkSchedulesData() {
        self.weekDays.forEach { day in
            let data = WorkScheduleEntity(context: database.container.viewContext)
            data.day = day.label.rawValue
            data.startTime = day.event.startTime
            data.endTime = day.event.endTime
        }
        
        let bedTime = BedTimeEntity(context: database.container.viewContext)
        bedTime.label = self.bedTime.label
        bedTime.startTime = self.bedTime.startTime
        bedTime.endTime = self.bedTime.endTime
        
        let wakeUpTime = BedTimeEntity(context: database.container.viewContext)
        wakeUpTime.label = self.wakeUpTime.label
        wakeUpTime.startTime = self.wakeUpTime.startTime
        wakeUpTime.endTime = self.wakeUpTime.endTime
        
        do {
            try database.container.viewContext.save()
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    private func storePlanData() {
        
        let plan = PlanEntity(context: database.container.viewContext)
        plan.title = self.planTitle
        plan.startDate = self.planStartDate
        plan.duration = Int16(self.planDuration)
        
        var learningTimeEntities: [LearningTimeEntity] = []
        
        learningTimeEntities = self.learningTimes.flatMap { time in
            
            return time.events.map { event in
                let data = LearningTimeEntity(context: database.container.viewContext)
                data.day = time.label.rawValue
                data.startTime = event.startTime
                data.endTime = event.endTime
                data.duration = Int16(event.duration ?? 0)
                
                return data
            }
            
        }
        
        plan.learningTimes = NSSet(array: learningTimeEntities)
        
        do {
            try database.container.viewContext.save()
            print("Stored successfully")
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func storeData() {
        self.storeWorkSchedulesData()
        self.storePlanData()
    }
}

