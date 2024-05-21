//
//  GoalsScreen.swift
//  Thirtys
//
//  Edited by Bayu Septyan Nur Hidayat on 20/05/24.
//

import SwiftUI

struct GoalsScreen: View {
    
    let date = ["SUN", "MON", "TUE", "WED", "THU", "FRI", "SAT"]
    
    @State private var selectedDay: String = "SUN"
    
    @Binding var goals_title: String
    @Binding var goals_duration: String
    
    var body: some View {
        NavigationStack{
            ZStack{
                Color.kBackground
                VStack(spacing: 24){
                    VStack(spacing: 24){
                        StaticFieldComponent(ContentField: "\(goals_title)", label: "What Knowledge Will You Unlock?")
                        StaticFieldComponent(ContentField: "\(goals_duration)", label: "Estimated Duration of Learning Plan")
                    }
                    .padding()
                    .background()
                    
                    VStack{
                        VStack(spacing: 24){
                            Text("Learning Time")
                                .font(.system(.body, weight: .bold))
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Picker("", selection: $selectedDay) {
                                ForEach(date, id: \.self) {
                                    Text($0)
                                        .font(.system(.caption2, weight: .semibold))
                                        .foregroundStyle(.kTitleText)
                                }
                            }
                            .pickerStyle(.segmented)
                        }
                        
                        if selectedDay == "SUN"{
                            VStack{
                                StaticFieldComponent(ContentField: "06.30 - 07.30", label: "")

                                StaticFieldComponent(ContentField: "20.00 - 22.45", label: "")
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
    GoalsScreen(goals_title: .constant("Belajar SwiftUI 1 Bulan"), goals_duration: .constant("May 18 - June 18 2024"))
}
