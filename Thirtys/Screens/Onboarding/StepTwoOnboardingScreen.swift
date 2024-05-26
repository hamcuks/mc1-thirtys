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
    @Binding var rootIsActive: Bool
    
    var body: some View {
        NavigationView {
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
                    
                    NavigationLink(
                        destination: StepThreeOnboardingScreen( isRootActive: self.$rootIsActive)
                            .navigationBarBackButtonHidden()
                    ) {
                        Text("Next")
                    }
                    .buttonStyle(AppButtonStyle())
                    .onSubmit {
                        print("step 2 \(rootIsActive)")
                    }
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
}

#Preview {
    StepTwoOnboardingScreen(rootIsActive: .constant(false))
        .environmentObject(OnboardingViewModel())
}
