//
//  GetStartedScreen.swift
//  Thirtys
//
//  Created by Ivan Nur Ilham Syah on 18/05/24.
//

import SwiftUI

struct GetStartedScreen: View {
    
    @StateObject private var onBoard = PathHandler()
    
    var body: some View {
        NavigationStack(path: $onBoard.path) {
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
                
                Button{
                    onBoard.path.append("oneOnBoard")
                } label: {
                    Text("Let's Start")
                }
                .buttonStyle(AppButtonStyle())
                .navigationDestination(for: String.self) { value in
                    if value == "oneOnBoard"{
                        StepOneOnboardingScreen()
                    } else if value == "twoOnBoard"{
                        StepTwoOnboardingScreen(isOnboarding: true)
                    } else if value == "threeOnBoard" {
                        StepThreeOnboardingScreen()
                    } else if value == "fourOnBoard" {
                        LearningTimeScreen()
                    }
                }
                
                
            }
            .padding(.horizontal)
        }
        .environmentObject(onBoard)
    }
}

#Preview {
    GetStartedScreen()
        .environmentObject(OnboardingViewModel())
}
