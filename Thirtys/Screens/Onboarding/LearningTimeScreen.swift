//
//  LearningTimeScreen.swift
//  Thirtys
//
//  Created by Ivan Nur Ilham Syah on 20/05/24.
//

import SwiftUI

struct LearningTimeScreen: View {
    
    var weekDays: [String] = [
        "SUN", "MON", "TUE", "WED", "THU", "FRI", "SAT"
    ]
    
    @State private var selectedDay: String = "SUN"
    
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
                    
                    VStack {
                        HStack(alignment: .top) {
                            ForEach(weekDays, id: \.self) { day in
                                
                                VStack {
                                    Text(day)
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
                                    selectedDay = day
                                }
                                
                            }
                        }
                        
                        ForEach(0..<1) { _ in
                            HStack {
                                Text("08.00 - 09.30")
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
                        }
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
        }
        
    }
}

#Preview {
    LearningTimeScreen()
}
