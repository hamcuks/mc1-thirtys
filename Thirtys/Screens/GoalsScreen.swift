//
//  GoalsScreen.swift
//  Thirtys
//
//  Edited by Bayu Septyan Nur Hidayat on 20/05/24.
//

import SwiftUI

struct GoalsScreen: View {
    
    let date = ["SUN", "MON", "TUE", "WED", "THU", "FRI", "SAT"]
    
    @Binding var goals_title: String
    @Binding var goals_duration: String
    
    var body: some View {
        NavigationStack{
            ZStack{
                Color.kBackground
                VStack{
                    VStack{
                        StaticFieldComponent(ContentField: "\(goals_title)", label: "What Knowledge Will You Unlock?").padding(.bottom, 24)
                        StaticFieldComponent(ContentField: "\(goals_duration)", label: "Estimated Duration of Learning Plan")
                    }
                    .padding()
                    .background()
                    .padding(.bottom, 24)
                    
                    VStack{
                        Text("Learning Time")
                            .font(.system(.body, weight: .bold))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.bottom, 24)
                        HStack{
                            Grid(horizontalSpacing: 32, verticalSpacing: 0){
                                GridRow{
                                    ForEach(date, id: \.hashValue) { i in
                                        VStack(){
                                            Text("\(i)")
                                                .font(.system(.caption2, weight: .semibold))
                                                .foregroundStyle(Color.kTitleText)
                                            
                                        }
                                    }
                                }
                                
                               
                            }
                        }
                        
                        StaticFieldComponent(ContentField: "06.30 - 07.30", label: "")

                        StaticFieldComponent(ContentField: "20.00 - 22.45", label: "")
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
