//
//  WorkScheduleView.swift
//  Thirtys
//
//  Created by Bayu Septyan Nur Hidayat on 26/05/24.
//

import SwiftUI

struct WorkScheduleView: View {
    
    @ObservedObject var vm: SettingViewModel
    
    var body: some View {
            Form {
                ForEach(vm.workingTimes, id: \.id) { weekdayEvent in
                    DisplaySectionWeek(
                        day: "\(weekdayEvent.label.term)",
                        startTime: Binding(
                            get: { weekdayEvent.events.first?.startTime ?? Date() },
                            set: { newStartTime in
                                // Implement update method in SettingViewModel
                            }
                        ),
                        endTime: Binding(
                            get: { weekdayEvent.events.first?.endTime ?? Date() },
                            set: { newEndTime in
                                // Implement update method in SettingViewModel
                            }
                        )
                    )
                }
            }
            .onAppear {
                vm.getWorkingSchedule()
            }
        }
}

struct DisplaySectionWeek: View {
    var day: String
    @Binding var startTime: Date
    @Binding var endTime: Date
    
    var body: some View {
        Section {
            HStack {
                Image(systemName: "clock.fill")
                    .foregroundStyle(Color.white)
                    .frame(width: 30, height: 30)
                    .background(Color.green)
                    .cornerRadius(7)
                DatePicker("Start Time", selection: $startTime, displayedComponents: .hourAndMinute)
                    .disabled(true)
            }
            HStack {
                Image(systemName: "clock.fill")
                    .foregroundStyle(Color.white)
                    .frame(width: 30, height: 30)
                    .background(Color.blue)
                    .cornerRadius(7)
                DatePicker("End Time",
                           selection: $endTime,
                           in: startTime...Calendar.current.date(
                            bySettingHour: 23,
                            minute: 59,
                            second: 59,
                            of: Date())!,
                           displayedComponents: .hourAndMinute)
                .disabled(true)
            }
        } header: {
            Text("\(day)")
        }
    }
}

#Preview {
    WorkScheduleView(vm: SettingViewModel())
}
