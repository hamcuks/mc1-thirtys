//
//  LearningTimeScreen.swift
//  Thirtys
//
//  Created by Ivan Nur Ilham Syah on 20/05/24.
//

import SwiftUI

struct LearningTimeScreen: View {
    
    @EnvironmentObject private var vm: OnboardingViewModel
    
    @AppStorage("firstInstall") private var isFirstInstall = true
    
    var notification = NotificationHandler()
    
    var body: some View {
        NavigationStack {
            VStack {
                
                VStack(spacing: 40) {
                    Image(.learningTime)
                        .resizable()
                        .scaledToFit()
                        .frame(maxHeight: 210)
                    
                    VStack (spacing: 16) {
                        Text("Here Is Your Learning Time!")
                            .font(.title2)
                            .bold()
                            .foregroundStyle(.kTitleText)
                        Text("Here’s our recommended learning time. Simply dedicate 30 minutes to each session as outlined below")
                            .font(.callout)
                            .fontWeight(.medium)
                            .foregroundStyle(.kBody)
                            .multilineTextAlignment(.center)
                    }
                    
                    LearningTimeList(items: vm.learningTimes)
                }
                
                Spacer()
                
                NavigationLink(
                    destination: TabViewComponent()
                        .onAppear {
                            isFirstInstall = false
                        }
                ) {
                    Text("Save")
                }
                .buttonStyle(AppButtonStyle())
                
            }
            .onDisappear {
                vm.storeData()
                for learningTime in vm.learningTimes{
                    for eventTime in learningTime.events {
                        notification.scheduleLearningNotifications(suggestionTimes: [eventTime])
                    }
                }
            }
            .scrollIndicators(.hidden)
            .toolbar(content: {
                ToolbarItem(placement: .topBarLeading) {
                    BackButton()
                }
            })
            .padding(.horizontal)
            .navigationTitle("Learning Time")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden()
            .onAppear {
                vm.getLearningTime()
            }
        }
        
    }
}

#Preview {
    LearningTimeScreen()
        .environmentObject(OnboardingViewModel())
}
