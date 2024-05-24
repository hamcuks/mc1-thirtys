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
    
    @EnvironmentObject private var todayVm: TodayViewModel
    
    @State private var showAchievementPopup: Bool = false
    @State private var isConfirmationStopOpen: Bool = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    
                    DailyStreak()
                    
                    VStack(spacing: 32) {
                        if countdownTimerViewModel.remainingTime > 0 {
                            learningTimeInfo
                            progressBar
                            timerButtons
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
                    
                    LearningHistory(historyLearning: countdownTimerViewModel.learningHistory)
                }
                .background(.kBackground)
                .padding(.bottom, 60)
                .toolbar {
                    streakToolbar
                }
            }
            .navigationTitle("Thirty's")
            .navigationBarTitleDisplayMode(.inline)
        }
        .refreshable {
            todayVm.getPlanData()
            todayVm.getTodayLearningPlan()
        }
        .onAppear {
            todayVm.getPlanData()
            todayVm.getTodayLearningPlan()
            countdownTimerViewModel.checkForNewDay()
        }
        .sheet(isPresented: $showAchievementPopup) {
            BadgeComponent(image: achievementViewModel.imageTitle, title: achievementViewModel.titleBadge, desc: achievementViewModel.descBadge, showAchievementPopup: $showAchievementPopup)
                .presentationCompactAdaptation(.fullScreenCover)
        }
        .sheet(isPresented: $isConfirmationStopOpen) {
            ConfirmationStopLearningComponent(isConfirmationStopOpen: $isConfirmationStopOpen) {
                countdownTimerViewModel.resetTimer()
                countdownTimerViewModel.hasStarted = false
            }
        }
    }
    
    // Subview learning time info
    private var learningTimeInfo: some View {
        VStack(spacing: 8) {
            Text("\(todayVm.plan?.title ?? "Title")")
                .font(.system(.title2, weight: .bold))
            
            if let event = todayVm.currentLearningTime {
                Text(event.startTime >= .now && event.endTime <= .now ? "Your learning time is at " : "Your next learning time will be available at ") +
                Text(event.startTime, style: .time) +
                Text(" - ") +
                Text(event.endTime, style: .time)
                    .font(.system(.footnote, weight: .regular))
            } else {
                Text("You do not have active learning time")
                    .font(.system(.footnote, weight: .regular))
            }
        }
    }
    
    // Subview progress bar
    private var progressBar: some View {
        VStack {
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
    }
    
    // Subview timer buttons
    private var timerButtons: some View {
        HStack {
            if countdownTimerViewModel.hasStarted {
                Button {
                    if countdownTimerViewModel.isActive {
                        countdownTimerViewModel.pauseTimer()
                    } else {
                        countdownTimerViewModel.startTimer()
                    }
                } label: {
                    HStack {
                        Image(systemName: countdownTimerViewModel.isActive ? "pause.fill" : "play.fill")
                        Text(countdownTimerViewModel.isActive ? "Pause" : "Resume")
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
                .buttonStyle(AppButtonStyle(backgroundColor: .kError.opacity(0.1), foregroundColor: .kError))
            } else {
                Button {
                    countdownTimerViewModel.startTimer()
                } label: {
                    HStack {
                        Image(systemName: "play.fill")
                        Text("Start Learning")
                    }
                }
                .buttonStyle(AppButtonStyle())
            }
        }
    }
    
    // Subview toolbar
    private var streakToolbar: some View {
        HStack {
            Image(systemName: "flame.fill")
            Text("\(achievementViewModel.dailyStrike)")
                .font(.system(.body, weight: .black))
        }
        .foregroundStyle(Color.kStreak)
    }
    
    private func updateDailyStreak() {
        achievementViewModel.dailyStrike += 1
        if achievementViewModel.getAchievement() {
            showAchievementPopup = true
        }
    }
}

#Preview {
    TodayScreen()
        .environmentObject(TodayViewModel())
}
