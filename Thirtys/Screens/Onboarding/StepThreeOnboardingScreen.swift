//
//  StepThreeOnboardingScreen.swift
//  Thirtys
//
//  Created by Ivan Nur Ilham Syah on 20/05/24.
//

import SwiftUI

struct StepThreeOnboardingScreen: View {
    
    @State private var isTimePickerOpened: Bool = false
    @EnvironmentObject private var vm: OnboardingViewModel
    @EnvironmentObject var pathHolder: PathHandler
    
    var body: some View {
        VStack {
            VStack(spacing: 40) {
                Image(.bedTime)
                    .resizable()
                    .scaledToFit()
                    .frame(maxHeight: 210)
                
                VStack (spacing: 16) {
                    Text("Let Us Know Your Bed Time!")
                        .font(.title2)
                        .bold()
                        .foregroundStyle(.kTitleText)
                    Text("Setting your bedtime helps us provide more accurate recommendations")
                        .font(.callout)
                        .fontWeight(.medium)
                        .foregroundStyle(.kBody)
                        .multilineTextAlignment(.center)
                }
                
                VStack(spacing: 16) {
                    TimePickerThrough(
                        label: "Bed Time",
                        selection: $vm.bedTime.startTime,
                        in: ...vm.bedTime.endTime
                    )
                    
                    TimePickerFrom(
                        label: "Wake Up Time",
                        selection: $vm.wakeUpTime.endTime,
                        in: vm.wakeUpTime.startTime...
                    )
                }
            }
            
            Spacer()
            
            Button {
                if pathHolder.isSettingOpen{
                    pathHolder.path.append("fourFromSetting")
                } else {
                    pathHolder.path.append("fourOnBoard")
                }
            } label: {
                Text("Next")
            }
            .buttonStyle(AppButtonStyle())
            
//            NavigationLink(
//                destination: LearningTimeScreen()
//            ) {
//                Text("Next")
//            }
//            .buttonStyle(AppButtonStyle())
//            .onAppear(perform: {
//                pathHolder.path.append("LearningTimeScreen")
//            })
            
        }
        .scrollIndicators(.hidden)
        .toolbar(content: {
            ToolbarItem(placement: .topBarLeading) {
                BackButton()
            }
        })
        .padding(.horizontal)
        .navigationTitle("Step 3/3")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
    }
    
}




#Preview {
    StepThreeOnboardingScreen()
        .environmentObject(OnboardingViewModel())
}
