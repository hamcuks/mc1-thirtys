//
//  ReconfigureView.swift
//  Thirtys
//
//  Created by Bayu Septyan Nur Hidayat on 26/05/24.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var pathHolder: PathHandler
    @EnvironmentObject var vm : SettingViewModel
    
    var body: some View {
        
            VStack{
                List{
                    Section(header: Text("Schedules Information")) {
                        ForEach(vm.setting, id: \.id){ i in
                            NavigationLink(destination: destinationView(for: i)){
                                HStack {
                                    Image(systemName: i.imageName)
                                        .foregroundStyle(Color.white)
                                        .frame(width: 30, height: 30)
                                        .background(i.color)
                                        .cornerRadius(7)
                                    Text(i.name)
                                }
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: 150)
                .listRowSpacing(8)
                .listStyle(.plain)
                
                
                Button{
                    pathHolder.isSettingOpen.toggle()
                    pathHolder.path.append("twoFromSetting")
                } label: {
                    Text("Reconfigure Schedules")
                }
                .padding()
                .buttonStyle(AppButtonStyle())
                
                
                Spacer()
            }
            .onAppear{
                vm.getBedSchedule()
                vm.getWorkingSchedule()
        }
    }
    
    
    private func destinationView(for setting: Platform) -> some View {
        if setting.name == "Work Time" {
            return AnyView(WorkScheduleView(vm: vm))
        } else if setting.name == "Bed Time" {
            return AnyView(BedTimeView(vm: vm))
        } else {
            // Handle other cases here
            return AnyView(EmptyView())
        }
    }
    
    
}





#Preview {
    SettingsView()
        .environmentObject(SettingViewModel())
}

