//
//  GoalsScreen.swift
//  Thirtys
//
//  Edited by Bayu Septyan Nur Hidayat on 20/05/24.
//

import SwiftUI

struct GoalsScreen: View {
    
    @EnvironmentObject private var goalViewModel: GoalViewModel
    
    let date = ["SUN", "MON", "TUE", "WED", "THU", "FRI", "SAT"]
    
    @State private var arr: [String] = []
    
    
    var body: some View {
        NavigationStack{
            ZStack{
                Color.kBackground
                VStack(spacing: 24){
                    VStack(spacing: 24){
                        StaticFieldComponent(ContentField: "\(goalViewModel.goalsTitle)", label: "What Knowledge Will You Unlock?")
                        StaticFieldComponent(ContentField: "\(goalViewModel.goalsDuration)", label: "Estimated Duration of Learning Plan")
                    }
                    .padding()
                    .background()
                    
                    VStack{
                        VStack(spacing: 24){
                            Text("Learning Time")
                                .font(.system(.body, weight: .bold))
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            HStack(alignment: .top) {
                                ForEach(date, id: \.self) { day in
                                    
                                    VStack {
                                        Text(day)
                                            .font(.subheadline)
                                            .foregroundStyle(.kBody)
                                            .frame(maxWidth: .infinity)
                                        
                                        if goalViewModel.selectedDay == day {
                                            Rectangle()
                                                .fill(.kTitleText)
                                                .frame(height: 3)
                                        }
                                    }
                                    .onTapGesture {
                                        goalViewModel.selectedDay = day
                                        arr = goalViewModel.getSuggestionTime(selectedDay: goalViewModel.selectedDay)
                                    }
                                }
                            }
                        }
                        
                        ForEach(arr, id: \.self){ i in
                            VStack{
                                StaticFieldComponent(ContentField: i, label: "")
                            }
                        }
                        
                    }
                    .padding()
                    .background()
                    
                    Spacer()
                }
            }
            .navigationTitle("Goal")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    GoalsScreen()
        .environmentObject(GoalViewModel())
}
