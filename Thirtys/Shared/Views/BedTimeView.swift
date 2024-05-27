//
//  BedTimeView.swift
//  Thirtys
//
//  Created by Bayu Septyan Nur Hidayat on 26/05/24.
//

import SwiftUI

struct BedTimeView: View {
    
    @ObservedObject var vm: SettingViewModel
    
    var body: some View {
        Form {
            Section {
                HStack {
                    Image(systemName: "clock.fill")
                        .foregroundStyle(Color.white)
                        .frame(width: 30, height: 30)
                        .background(Color.green)
                        .cornerRadius(7)
                    DatePicker("Start Time", selection: $vm.bedTime.startTime, displayedComponents: .hourAndMinute)
                        .disabled(true)
                    
                }
                HStack {
                    Image(systemName: "clock.fill")
                        .foregroundStyle(Color.white)
                        .frame(width: 30, height: 30)
                        .background(Color.blue)
                        .cornerRadius(7)
                    DatePicker("End Time",
                               selection: $vm.wakeUpTime.endTime,
                               displayedComponents: .hourAndMinute)
                        .disabled(true)
                }
            } header: {
                Text("Bed Time")
            }
        }
    }
}



#Preview {
    BedTimeView(vm: SettingViewModel())
}
