//
//  HomeScreen.swift
//  Thirtys
//
//  Created by Ivan Nur Ilham Syah on 18/05/24.
//

import SwiftUI

struct TodayScreen: View {
    @StateObject private var countdownTimerViewModel = CountdownTimerViewModel()
    @StateObject private var goalViewModel = GoalViewModel()
    @StateObject private var achievementViewModel = AchievementViewModel()
    
    @State private var showAchievementPopup: Bool = false
    @State private var isLearningStarted: Bool = false
    @State private var isConfirmationStopOpen: Bool = false
    
    var body: some View {
        NavigationView {
            ScrollView{
                VStack(spacing: 24) {
                    
                    DailyStreak()
                    
                    VStack(spacing: 32){
                        if countdownTimerViewModel.remainingTime > 0 {
                            VStack(spacing:8){
                                Text("\(goalViewModel.plan?.title ?? "Title")")
                                    .font(.system(.title2, weight: .bold))
                                Text("Your learning time is available at 06.00 - 07.30")
                                    .font(.system(.footnote, weight: .regular))
                            }
                            VStack{
                                ZStack {
                                    CircularProgressBar(progress: CGFloat(countdownTimerViewModel.remainingTime / 1800))
                                    
                                    VStack {
                                        Text("\(timeString(from: countdownTimerViewModel.remainingTime))")
                                            .font(.system(size: 36))
                                            .bold()
                                            .foregroundStyle(Color.kLabel)
                                            .contentTransition(.numericText())
                                        Text("Remaining")
                                            .font(.system(size: 16))
                                            .bold()
                                            .foregroundStyle(Color.kPlaceholder)
                                    }
                                }
                            }
                            HStack {
                                if !isLearningStarted {
                                    Button(action: {
                                        countdownTimerViewModel.startTimer()
                                        isLearningStarted.toggle()
                                    }) {
                                        HStack {
                                            Image(systemName: "play.fill")
                                            Text("Start Learning")
                                        }
                                    }
                                    .buttonStyle(AppButtonStyle())
                                } else {
                                    Button {
                                        if countdownTimerViewModel.isActive {
                                            countdownTimerViewModel.pauseTimer()
                                        } else {
                                            countdownTimerViewModel.startTimer()
                                        }
                                    } label: {
                                        
                                        HStack {
                                            if countdownTimerViewModel.isActive {
                                                Image(systemName: "pause.fill")
                                                Text("Pause")
                                            } else {
                                                Image(systemName: "play.fill")
                                                Text("Resume")
                                            }
                                        }
                                        
                                    }
                                    .buttonStyle(AppButtonStyle())
                                    
                                    
                                    Button {
                                        isConfirmationStopOpen.toggle()
                                    } label: {
                                        HStack {
                                            Image(systemName: "flag.fill")
                                            Text("Stop")
                                        }
                                    }
                                    .buttonStyle(
                                        AppButtonStyle(
                                            backgroundColor: .kError.opacity(0.1),
                                            foregroundColor: .kError
                                        )
                                    )
                                }
                            }
                            
                        } else {
                            FinishComponent()
                                .frame(alignment: .center)
                                .onAppear {
                                    updateDailyStreak()
                                }
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 24)
                    .padding(.horizontal, 16)
                    .background(.white)
                    
                    LearningHistory(
                        historyLearning: countdownTimerViewModel.learningHistory
                    )
                    
                }
                .background(.kBackground)
                .padding(.bottom, 60)
                .toolbar{
                    HStack{
                        Image(systemName: "flame.fill")
                        Text("\(achievementViewModel.dailyStrike)")
                            .font(.system(.body, weight: .black))
                    }
                    .foregroundStyle(Color.kStreak)
                }
            }
            .navigationTitle("Thirty's")
            .navigationBarTitleDisplayMode(.inline)
        }
        .sheet(isPresented: $showAchievementPopup){
            BadgeComponent(image: achievementViewModel.imageTitle, title: achievementViewModel.titleBadge, desc: achievementViewModel.descBadge, showAchievementPopup: $showAchievementPopup)
                .presentationCompactAdaptation(.fullScreenCover)
            
        }
        .sheet(isPresented: $isConfirmationStopOpen){
            ConfirmationStopLearningComponent(isConfirmationStopOpen: $isConfirmationStopOpen) {
                countdownTimerViewModel.resetTimer()
                isLearningStarted = false
            }
        }
    }
    
    func updateDailyStreak() {
        achievementViewModel.dailyStrike += 1
        if achievementViewModel.getAchievement() {
            showAchievementPopup = true
        }
    }
}

#Preview {
    TodayScreen()
}
