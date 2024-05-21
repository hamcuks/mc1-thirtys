//
//  GetStartedScreen.swift
//  Thirtys
//
//  Created by Ivan Nur Ilham Syah on 18/05/24.
//

import SwiftUI

struct GetStartedScreen: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 40) {
                Spacer()
                
                Image(.only30Minutes)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 274)
                
                VStack (spacing: 16) {
                    Text("You only need 30 minutes a day!")
                        .font(.title2)
                        .bold()
                        .foregroundStyle(.kTitleText)
                    Text("Success comes from small daily efforts. Dedicate just 30 minutes each day, and research shows this can lead to significant progress over time.")
                        .font(.callout)
                        .fontWeight(.medium)
                        .foregroundStyle(.kBody)
                        .multilineTextAlignment(.center)
                }
                
                Spacer()
                
                NavigationLink(
                    destination: StepOneOnboardingScreen()
                ) {
                    Text("Let's Start")
                }
                .buttonStyle(AppButtonStyle())
                
            }
            .padding()
        }
    }
}

#Preview {
    GetStartedScreen()
        .environmentObject(OnboardingViewModel())
}
