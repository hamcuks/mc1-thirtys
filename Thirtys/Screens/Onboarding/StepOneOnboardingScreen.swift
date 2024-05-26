//
//  OnboardingScreen.swift
//  Thirtys
//
//  Created by Ivan Nur Ilham Syah on 18/05/24.
//

import SwiftUI

struct StepOneOnboardingScreen: View {
    
    @EnvironmentObject private var vm: OnboardingViewModel
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 40) {
                    Image(.goals)
                        .resizable()
                        .scaledToFit()
                        .frame(maxHeight: 210)
                    
                    VStack (spacing: 16) {
                        Text("Define Your Goals!")
                            .font(.title2)
                            .bold()
                            .foregroundStyle(.kTitleText)
                        Text("Setting clear goals unlocks new behaviors, enhances your focus, and keeps your momentum going")
                            .font(.callout)
                            .fontWeight(.medium)
                            .foregroundStyle(.kBody)
                            .multilineTextAlignment(.center)
                    }
                    
                    VStack(spacing: 24) {
                        AppTextField(
                            selection: $vm.planTitle,
                            label: "What Knowledge Will You Unlock?",
                            placeholder: "e.g., Belajar SwiftUI"
                        )
                        AppDatePicker(
                            selection: $vm.planStartDate,
                            label: "Estimated Duration of Learning Plan",
                            placeholder: "e.g., May 5 - June 5 2024"
                        )
                        AppDurationPicker(
                            selection: $vm.planDuration,
                            label: "How fast can you achieve this goal?",
                            placeholder: "e.g., May 5 - June 5 2024"
                        )
                    }
                    
                    NavigationLink(
                        destination: StepTwoOnboardingScreen(rootIsActive: .constant(false))
                    ) {
                        Text("Next")
                    }
                    .buttonStyle(AppButtonStyle())
                    .grayscale((vm.planTitle.isEmpty || vm.planDuration < 7) ? 1 : 0)
                    .disabled((vm.planTitle.isEmpty || vm.planDuration < 7))
                }
                
                
            }
            .toolbar(content: {
                ToolbarItem(placement: .topBarLeading) {
                    BackButton()
                }
            })
            .contentMargins(16, for: .scrollContent)
            .navigationTitle("Step 1/3")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden()
        }
    }
}

#Preview {
    StepOneOnboardingScreen()
        .environmentObject(OnboardingViewModel())
}
