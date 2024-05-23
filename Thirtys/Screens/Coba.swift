//
//  Coba.swift
//  Thirtys
//
//  Created by Bayu Septyan Nur Hidayat on 22/05/24.
//

import SwiftUI


struct Coba: View {
    @StateObject private var countdownTimerViewModel = CountdownTimerViewModel()
    @StateObject private var goalViewModel = GoalViewModel()
    @StateObject private var achievementViewModel = AchievementViewModel()
    
    @State private var showAchievementPopup = false

    var body: some View {
        NavigationView {
            ScrollView{
                ZStack {
                    Color.kBackground
                    VStack(spacing: 24) {
                        DailyStreak()
                            .padding(.top)
                        VStack{
                            if countdownTimerViewModel.remainingTime > 0 {
                                VStack(spacing:8){
                                    Text("\(goalViewModel.goalsTitle)")
                                        .font(.system(.title2, weight: .bold))
                                    Text("Your learning time is available at 06.00 - 07.30")
                                        .font(.system(.footnote, weight: .regular))
                                }
                                .padding(.top, 24)
                                .padding(.bottom, 32)
                                VStack{
                                    ZStack {
                                        CircularProgressBar(progress: CGFloat(countdownTimerViewModel.remainingTime) / 1800)
                                        
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
                                .padding(.bottom, 32)
                                HStack {
                                    Button {
                                        if countdownTimerViewModel.isActive {
                                            countdownTimerViewModel.pauseTimer()
                                        } else {
                                            countdownTimerViewModel.startTimer()
                                        }
                                    } label: {
                                        if countdownTimerViewModel.isActive {
                                            Image(systemName: "pause.fill")
                                            Text("Pause")
                                        } else {
                                            Image(systemName: "play.fill")
                                            Text("Resume")
                                        }
                                        
                                    }
                                    .font(.system(.caption, weight: .bold))
                                    .frame(width: 164, height: 41)
                                    .foregroundColor(Color.kLabel)
                                    .background(Color.kAccent)
                                    .cornerRadius(45)
                                    
                                    Button {
                                        countdownTimerViewModel.resetTimer()
                                    } label: {
                                        Image(systemName: "flag.fill")
                                        Text("Stop")
                                    }
                                    .frame(width: 164, height: 41)
                                    .font(.system(.caption, weight: .bold))
                                    .foregroundColor(Color.kError)
                                    .background(Color.kError.opacity(0.15))
                                    .cornerRadius(45)
                                }
                                .padding(.bottom, 24)
                                
                            } else {
                                VStack {
                                    FinishComponent()
                                        .frame(alignment: .center)
                                    
                                    // Check and update achievement when timer finishes
                                    .onAppear {
                                        updateAchievementIfNeeded()
                                    }
                                }
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .background(.white)
                        
                        LearningHistory(historyLearning: countdownTimerViewModel.learningHistory)
                    }
                    .padding(.bottom, 60)
                }
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
        .sheet(isPresented: $showAchievementPopup) {
            AchievementPopupView(image: achievementViewModel.imageTitle, title: achievementViewModel.titleBadge, description: achievementViewModel.descBadge)
        }
    }

    // Function to check and update achievement
    func updateAchievementIfNeeded() {
        achievementViewModel.dailyStrike += 1
        if achievementViewModel.getAchievement() {
            showAchievementPopup = true
        }
    }
}

struct AchievementPopupView: View {
    let image: String
    let title: String
    let description: String
    
    var body: some View {
        VStack {
            Image(image)
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
            Text(title)
                .font(.title)
                .bold()
            Text(description)
                .font(.body)
                .padding()
            Button("Close") {
                // Handle close action
            }
            .padding()
        }
        .padding()
    }
}


#Preview {
    Coba()
}
