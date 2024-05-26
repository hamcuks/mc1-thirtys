//
//  StepTwoOnboardingScreen.swift
//  Thirtys
//
//  Created by Ivan Nur Ilham Syah on 20/05/24.
//

import SwiftUI

struct StepTwoOnboardingScreen: View {
    
    @State private var isTimePickerOpened: Bool = false
    @EnvironmentObject private var vm: OnboardingViewModel
    @EnvironmentObject var pathHolder: PathHandler
    var isOnboarding: Bool = false
    
    var body: some View {
        
        ScrollView {
            VStack(spacing: 40) {
                Image(.workSchedules)
                    .resizable()
                    .scaledToFit()
                    .frame(maxHeight: 210)
                
                VStack (spacing: 16) {
                    Text("Your Work Schedules!")
                        .font(.title2)
                        .bold()
                        .foregroundStyle(.kTitleText)
                    Text("Setting your work hours allows us to allocate your time effectively")
                        .font(.callout)
                        .fontWeight(.medium)
                        .foregroundStyle(.kBody)
                        .multilineTextAlignment(.center)
                }
                
                VStack(spacing: 16) {
                    ForEach(Array(vm.weekDays.enumerated()), id: \.offset) { (index, day) in
                        ListItemComponent(
                            data: $vm.weekDays[index]
                        )
                    }
                }
                
                Button {
                    Task {
                           if !isOnboarding {
                               pathHolder.path.append("threeFromSetting")
                           } else if isOnboarding{
                               pathHolder.path.append("threeOnBoard")
                           }
                       }
                    
                } label: {
                    Text("Next")
                }
                .buttonStyle(AppButtonStyle())
                
                //                    NavigationLink(
                //                        destination: StepThreeOnboardingScreen()
                //                    ) {
                //                        Text("Next")
                //                    }
                //                    .buttonStyle(AppButtonStyle())
                //                    .onAppear(perform: {
                //                        pathHolder.path.append("StepThreeOnboardingScreen")
                //                    })
                
            }
        }
        .scrollIndicators(.hidden)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                BackButton()
            }
        }
        .contentMargins(16, for: .scrollContent)
        .navigationTitle("Step 2/3")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
    }
    
}

#Preview {
    StepTwoOnboardingScreen()
        .environmentObject(OnboardingViewModel())
}
