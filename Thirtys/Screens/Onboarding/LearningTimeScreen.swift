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
                    Image(.bedTime)
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
                    
                    Picker("", selection: $selectedDay) {
                        ForEach(weekDays, id: \.self) {
                            Text($0)
                                .font(.subheadline)
                                .foregroundStyle(.kBody)
                        }
                    }
                    .pickerStyle(.segmented)
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
