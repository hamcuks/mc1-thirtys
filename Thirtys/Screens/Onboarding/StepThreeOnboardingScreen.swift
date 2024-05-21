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
    
    var body: some View {
        NavigationStack {
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
                        DatePicker(
                            "Bed Time",
                            selection: $vm.bedTime.startTime,
                            in: ...vm.bedTime.endTime,
                            displayedComponents: [.hourAndMinute]
                        )
                        DatePicker(
                            "Wake Up Time",
                            selection: $vm.wakeUpTime.endTime,
                            in: vm.wakeUpTime.startTime...,
                            displayedComponents: [.hourAndMinute]
                        )
                    }
                }
                
                Spacer()
                
                NavigationLink(
                    destination: LearningTimeScreen()
                ) {
                    Text("Next")
                }
                .buttonStyle(AppButtonStyle())
                
            }
            .scrollIndicators(.hidden)
            .toolbar(content: {
                ToolbarItem(placement: .topBarLeading) {
                    BackButton()
                }
            })
            .padding()
            .navigationTitle("Step 3/3")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden()
        }
    }
}


#Preview {
    StepThreeOnboardingScreen()
        .environmentObject(OnboardingViewModel())
}
