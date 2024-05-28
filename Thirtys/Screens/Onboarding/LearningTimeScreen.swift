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
    @EnvironmentObject var pathHolder: PathHandler
    
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
                    
                    
                    VStack{
                        Text("Range of available schedules time")
                            .font(.body)
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity,alignment: .leading)
                            .padding(.bottom, 10)
                        LearningTimeList(items: vm.learningTimes)
                            .frame(height: 175)
                        Text("Notes: This schedule might be same as your work time and bed time input")
                            .font(.caption2)
                            .fontWeight(.semibold)
                            .frame(width: .infinity, height: 30,alignment: .leading)
                    }
                    
                }
                
               
                
                Spacer()
                
                Button {
                    
                    if !isFirstInstall{
                        pathHolder.path.removeLast(pathHolder.path.count)
                    } else {
                        isFirstInstall = false
                    }
                } label: {
                    Text("Next")
                }
                .buttonStyle(AppButtonStyle())
                
                
//                NavigationLink(
//                    destination: TabViewComponent()
//                        .onAppear {
//                            isFirstInstall = false
//                            
//                            if pathHolder.isSettingOpen {
//                                pathHolder.path.removeLast(pathHolder.path.count)
//                            }
                            
//                            if svm.isFromSetting{
//                                
//                                print("coba \(svm.path)")
//                                svm.path.removeLast(svm.path.count)
//                                isFirstInstall = false
//                            }
                            
                            
//                        }
//                ) {
//                    Text("Save")
//                }
//                .buttonStyle(AppButtonStyle())
                
//                Button{
//                    if isFirstInstall {
//                        NavigationLink(destination: TabViewComponent(), isActive: $isFirstInstall) {
//                            EmptyView()
//                                .onAppear{
//                                    isFirstInstall = false
//                                }
//                        }
//                    } else if !isFirstInstall {
//                        path.removeLast(path.count)
//                    }
//                } label: {
//                    Text("Save")
//                }
//                .buttonStyle(AppButtonStyle())
                
                
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
    LearningTimeScreen()
        .environmentObject(OnboardingViewModel())
}
