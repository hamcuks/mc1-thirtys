//
//  WorkScheduleView.swift
//  Thirtys
//
//  Created by Bayu Septyan Nur Hidayat on 26/05/24.
//

import SwiftUI

struct WorkScheduleView: View {
    
    @State private var startTime = Date()
    @State private var endTime = Date()
    
    var body: some View {
        Form {
            DisplaySectionWeek(day: "Sunday", startTime: $startTime, endTime: $endTime)
            DisplaySectionWeek(day: "Monday", startTime: $startTime, endTime: $endTime)
            DisplaySectionWeek(day: "Tuesday", startTime: $startTime, endTime: $endTime)
            DisplaySectionWeek(day: "Wednesday", startTime: $startTime, endTime: $endTime)
            DisplaySectionWeek(day: "Thusday", startTime: $startTime, endTime: $endTime)
            DisplaySectionWeek(day: "Friday", startTime: $startTime, endTime: $endTime)
            DisplaySectionWeek(day: "Saturday", startTime: $startTime, endTime: $endTime)
            
            
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
    WorkScheduleView()
}
