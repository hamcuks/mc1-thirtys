//
//  SettingViewModel.swift
//  Thirtys
//
//  Created by Bayu Septyan Nur Hidayat on 26/05/24.
//

import SwiftUI
import CoreData

class SettingViewModel: ObservableObject {
    private let planService: PlanService = PlanService.shared
    private let userPrefService: UserPreferenceService = UserPreferenceService.shared
    
    @Published var workingTimes: [GrouppedWeekdayEvent] = []
    @Published var bedTimes: [[Event]] = []
    
    @Published var bedTime: Event = Event(label: "Bed Time", startTime: Date(), endTime: Date())
    @Published var wakeUpTime: Event = Event(label: "Wake Up Time", startTime: Date(), endTime: Date())
        
    @Published var setting : [Platform] = [
        .init(name: "Work Time", imageName: "bag.fill", color: Color.orange),
        .init(name: "Bed Time", imageName: "bed.double.fill", color: Color.green)]
    
    
    func getWorkingSchedule(){
        
        // Convert workingTimes object to Array
        let items = userPrefService.getWorkSchedules()
        
        
        // Get the working time weekday
        let weekday: [Int16] = Set(items.map { $0.day }).sorted()
        
        // Create GrouppedWeekdayEvent based on weekday data
        self.workingTimes = weekday.map { day in
            let events = items.filter { $0.day == day }
                
            return GrouppedWeekdayEvent(
                label: WeekdayType(rawValue: day)!,
                events: events.map {
                    Event(
                        label: "\(String(describing: WeekdayType(rawValue: $0.day)?.term))",
                        startTime: $0.startTime!,
                        endTime: $0.endTime!
                    )
                }.sorted {
                    return $0.startTime.compare($1.startTime) == .orderedAscending
                }
            )
        }
    
    }
    
    func getBedSchedule() {
            // Dapatkan data jadwal tidur dari UserPreferenceService
            let items = userPrefService.getBedSchedules()
            
            // Kelompokkan jadwal tidur berdasarkan label
            let bedLabels: [String] = Set(items.map { $0.label! }).sorted()
            // Inisialisasi array untuk menyimpan grup Event
            var bedTimeGroups: [[Event]] = []
            
            // Buat GrouppedWeekdayEvent untuk setiap label
            bedLabels.forEach { label in
                // Filter item berdasarkan label
                let events = items.filter { $0.label == label }
                
                // Buat Event untuk setiap item
                let mappedEvents = events.map { event in
                    Event(
                        label: event.label ?? "",
                        startTime: event.startTime ?? Date(),
                        endTime: event.endTime ?? Date()
                    )
                }
                
                // Tambahkan grup Event ke array
                bedTimeGroups.append(mappedEvents.sorted { $0.startTime < $1.startTime })
            }
            
            // Tetapkan hasilnya ke bedTimes
            self.bedTimes = bedTimeGroups
            
            // Jika ada data, atur bedTime dan wakeUpTime ke nilai pertama dalam grup pertama
            if let firstGroup = bedTimeGroups.first, let firstEvent = firstGroup.first {
                self.bedTime = firstEvent
            }
            if let lastGroup = bedTimeGroups.last, let lastEvent = lastGroup.last {
                self.wakeUpTime = lastEvent
            }
        }
    





}
