//
//  HomeScreen.swift
//  Thirtys
//
//  Created by Ivan Nur Ilham Syah on 18/05/24.
//

import SwiftUI

struct TodayScreen: View {
    @EnvironmentObject private var todayVm: TodayViewModel
    @EnvironmentObject private var vm: SettingViewModel
    @StateObject private var pathHolder = PathHandler()
    
    @State private var isConfirmationStopOpen: Bool = false
    @State private var showOutOfRangeOptions: Bool = false

    
    var body: some View {
        NavigationStack(path: $pathHolder.path) {
            ZStack {
                ScrollView {
                    VStack(spacing: 24) {
                        
                        DailyStreak()
                        
                        VStack(spacing: 32) {
                            if !todayVm.todayLearningHasCompleted {
                                learningTimeInfo
                                progressBar
                                timerButtons
                            } else {
                                FinishComponent()
                                    .frame(alignment: .center)
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 24)
                        .padding(.horizontal, 16)
                        .background(.white)
                        
                        LearningHistory(historyLearning: todayVm.learningHistory)
                    }
                    .background(.kBackground)
                    .padding(.bottom, 60)
                    .toolbar {
                        ToolbarItem(placement: .topBarLeading) {
                            settingToolbar
                        }
                        ToolbarItem(placement: .topBarTrailing) {
                            streakToolbar
                        }
                        
                    }
                    
                    
                }
                .navigationTitle("Today")
                .navigationBarTitleDisplayMode(.inline)
                
                if todayVm.showBadge {
                    if let badge = todayVm.badgeData {
                        BadgePopUp(
                            badge: badge,
                            showAchievementPopup: $todayVm.showBadge
                        )
                    }   
                }
            }
        }
        .refreshable {
            todayVm.getPlanData()
            todayVm.getTodayLearningPlan()
            todayVm.getLearningStreaks()
            todayVm.checkTodayLearningState()
        }
        .onAppear {
            todayVm.getPlanData()
            todayVm.getTodayLearningPlan()
            todayVm.getLearningStreaks()
            todayVm.checkTodayLearningState()
            
        }
        .sheet(isPresented: $isConfirmationStopOpen) {
            ConfirmationStopLearningComponent(isConfirmationStopOpen: $isConfirmationStopOpen) {
                todayVm.resetTimer()
                todayVm.hasStarted = false
            }
        }
        .sheet(isPresented: $showOutOfRangeOptions) {
            LearningOutOfRangeSheet(showOutOfRangeOptions: $showOutOfRangeOptions) {
                todayVm.startTimer()
            }
        }
        .environmentObject(pathHolder)
    }
    
    
    // Subview learning time info
    private var learningTimeInfo: some View {
        VStack(spacing: 8) {
            Text("\(todayVm.plan?.title ?? "Plan Title")")
                .font(.system(.title2, weight: .bold))
                .foregroundStyle(.kTitleText)
            
            if let event = todayVm.currentLearningTime {
                (Text(event.startTime <= .now && event.endTime >= .now ? "Your learning time is at " : "Your next learning time will be available at ") +
                 Text(event.startTime, style: .time) +
                 Text(" - ") +
                 Text(event.endTime, style: .time))
                .font(.system(.subheadline, weight: .regular))
                .foregroundStyle(.kBody)
                .multilineTextAlignment(.center)
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
                CircularProgressBar(
                    progress: todayVm.remainingTime / todayVm.countdownInterval
                )
                
                VStack {
                    Text("\(timeString(from: todayVm.remainingTime))")
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
            if todayVm.hasStarted {
                Button {
                    if todayVm.isTimerActive {
                        todayVm.pauseTimer()
                    } else {
                        todayVm.startTimer()
                    }
                } label: {
                    HStack {
                        Image(systemName: todayVm.isTimerActive ? "pause.fill" : "play.fill")
                        Text(todayVm.isTimerActive ? "Pause" : "Resume")
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
            } else {
                Button {
                    if todayVm.isWithinLearningTime {
                        todayVm.startTimer()
                    } else {
                        showOutOfRangeOptions.toggle()
                    }
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
            Text("\(todayVm.dailyStreak)")
                .font(.system(.body, weight: .black))
        }
        .foregroundStyle(Color.kStreak)
    }
    
    // Subview settings toolbar
    private var settingToolbar: some View {
        HStack {
            Button{
                pathHolder.path.append("setting")
            } label: {
                Image(systemName: "gear.circle.fill")
            }
            .navigationDestination(for: String.self) { value in
                if value == "setting"{
                    SettingsView()
                } else if value == "twoFromSetting"{
                    StepTwoOnboardingScreen()
                } else if value == "threeFromSetting" {
                    StepThreeOnboardingScreen()
                } else if value == "fourFromSetting" {
                    LearningTimeScreen()
                }
            }
        }
        .foregroundStyle(Color.kBody)
    }
}

#Preview {
    TodayScreen()
        .environmentObject(TodayViewModel())
        .environmentObject(SettingViewModel())
}
