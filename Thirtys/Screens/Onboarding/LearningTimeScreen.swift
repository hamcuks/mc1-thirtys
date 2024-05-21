//
//  LearningTimeScreen.swift
//  Thirtys
//
//  Created by Ivan Nur Ilham Syah on 20/05/24.
//

import SwiftUI

struct LearningTimeScreen: View {
    
    @State private var selectedDay: WeekdayType = .sunday
    @EnvironmentObject private var vm: OnboardingViewModel
    
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
                    
                    VStack(spacing: 16) {
                        HStack(alignment: .top) {
                            ForEach(WeekdayType.allCases, id: \.self) { day in
                                
                                VStack {
                                    Text("\(day.rawValue)")
                                        .font(.subheadline)
                                        .foregroundStyle(.kBody)
                                        .frame(maxWidth: .infinity)
                                    
                                    if selectedDay == day {
                                        Rectangle()
                                            .fill(.kTitleText)
                                            .frame(height: 3)
                                    }
                                }
                                .onTapGesture {
                                    withAnimation(.smooth) {
                                        selectedDay = day
                                    }
                                }
                                
                            }
                        }
                        
                        List {
                            if let learningTime = vm.learningTimes.first(where: { $0.label == selectedDay }) {
                                
                                ForEach(
                                    learningTime.events,
                                    id: \.hashValue
                                ) { time in
                                    HStack {
                                        Text(time.startTime, style: .time)
                                            .font(.subheadline)
                                            .fontWeight(.semibold)
                                            .foregroundStyle(.kTitleText)
                                        Text("-")
                                            .font(.subheadline)
                                            .fontWeight(.semibold)
                                            .foregroundStyle(.kTitleText)
                                        Text(time.endTime, style: .time)
                                            .font(.subheadline)
                                            .fontWeight(.semibold)
                                            .foregroundStyle(.kTitleText)
                                    }
                                    .padding(16)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .overlay {
                                        RoundedRectangle(cornerRadius: 8)
                                            .strokeBorder(
                                                .kAccent, lineWidth: 1.5
                                            )
                                    }
                                    .listRowInsets(
                                        EdgeInsets(
                                            .init(
                                                top: 0,
                                                leading: 0,
                                                bottom: 16,
                                                trailing: 0
                                            )
                                        )
                                    )
                                    .listRowSeparator(.hidden)
                                }
                                
                            }
                        }
                        .listStyle(.plain)
                    }
                }
                
                Spacer()
                
                NavigationLink(
                    destination: GetStartedScreen()
                ) {
                    Text("Next")
                }
                .buttonStyle(AppButtonStyle())
                
            }
            .scrollIndicators(.hidden)
            .toolbar(content: {
                ToolbarItem(placement: .topBarLeading) {
                    BackButton()
                }
            })
            .padding()
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
