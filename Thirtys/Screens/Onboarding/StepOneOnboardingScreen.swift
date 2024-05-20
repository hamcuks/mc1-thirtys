//
//  OnboardingScreen.swift
//  Thirtys
//
//  Created by Ivan Nur Ilham Syah on 18/05/24.
//

import SwiftUI

struct StepOneOnboardingScreen: View {
    
    @State private var planTitle: String = ""
    
    var body: some View {
        NavigationStack {
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
                        selection: $planTitle,
                        label: "What Knowledge Will You Unlock?",
                        placeholder: "e.g., Belajar SwiftUI"
                    )
                    AppTextField(
                        selection: $planTitle,
                        label: "Estimated Duration of Learning Plan",
                        placeholder: "e.g., May 5 - June 5 2024"
                    )
                }
                
                Spacer()
                
                NavigationLink(
                    destination: GetStartedScreen()
                ) {
                    AppButton(label: "Next")
                }
                .buttonStyle(.plain)
                .disabled(planTitle.isEmpty)
                
            }
            .toolbar(content: {
                ToolbarItem(placement: .topBarLeading) {
                    BackButton()
                }
            })
            .padding()
            .navigationTitle("Step 1/3")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden()
        }
    }
}

#Preview {
    StepOneOnboardingScreen()
}
