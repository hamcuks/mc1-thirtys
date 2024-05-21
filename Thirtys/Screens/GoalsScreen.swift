//
//  GoalsScreen.swift
//  Thirtys
//
//  Edited by Bayu Septyan Nur Hidayat on 20/05/24.
//

import SwiftUI

struct GoalsScreen: View {
    
    @EnvironmentObject private var gvm: GoalViewModel
    
    let date = ["SUN", "MON", "TUE", "WED", "THU", "FRI", "SAT"]
    
    @State private var arr: [String] = []
    
    
    var body: some View {
        NavigationStack{
            ZStack{
                Color.kBackground
                VStack(spacing: 24){
                    VStack(spacing: 24){
                        StaticFieldComponent(ContentField: "\(gvm.goals_title)", label: "What Knowledge Will You Unlock?")
                        StaticFieldComponent(ContentField: "\(gvm.goals_duration)", label: "Estimated Duration of Learning Plan")
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
                                        
                                        if gvm.selectedDay == day {
                                            Rectangle()
                                                .fill(.kTitleText)
                                                .frame(height: 3)
                                        }
                                    }
                                    .onTapGesture {
                                        gvm.selectedDay = day
                                        arr = gvm.getSuggestionTime(selectedDay: gvm.selectedDay)
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
