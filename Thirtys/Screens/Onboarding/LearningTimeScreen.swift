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
    
    @Binding var path: NavigationPath
    
    var notification = NotificationHandler()
    
    var body: some View {
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
                
//                
//                NavigationLink(
//                    destination: TabViewComponent()
//                        .onAppear {
//                            isFirstInstall = false
//                            
//                            if svm.isFromSetting{
//                                
//                                print("coba \(svm.path)")
//                                svm.path.removeLast(svm.path.count)
//                                isFirstInstall = false
//                            }
//                            
//                            
//                        }
//                ) {
//                    Text("Save")
//                }
//                .buttonStyle(AppButtonStyle())
                
                Button{
                    if isFirstInstall {
                        NavigationLink(destination: TabViewComponent(), isActive: $isFirstInstall) {
                            EmptyView()
                                .onAppear{
                                    isFirstInstall = false
                                }
                        }
                    } else if !isFirstInstall {
                        path.removeLast(path.count)
                    }
                } label: {
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

#Preview {
    LearningTimeScreen(path: .constant(NavigationPath()))
        .environmentObject(OnboardingViewModel())
}
