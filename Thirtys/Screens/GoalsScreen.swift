//
//  GoalsScreen.swift
//  Thirtys
//
//  Edited by Bayu Septyan Nur Hidayat on 20/05/24.
//

import SwiftUI

struct GoalsScreen: View {
    
    @EnvironmentObject private var vm: GoalViewModel
    
    var body: some View {
        NavigationStack{
            
            VStack(spacing: 24){
                
                VStack(spacing: 24){
                    AppTextField(
                        selection: .constant(vm.plan?.title ?? "Plan Title"),
                        label: "What Knowledge Will You Unlock?"
                    )
                    
                    AppDatePicker(
                        selection: .constant(vm.plan?.startDate ?? .now),
                        label: "Plan Start Date"
                    )
                    
                    if var startDate = vm.plan?.startDate, let duration = vm.plan?.duration {
                        let endDate = Calendar.current.date(
                            byAdding: .day,
                            value: Int(duration),
                            to: startDate
                        )
                        
                        AppDatePicker(
                            selection: .constant(endDate ?? .now),
                            label: "Plan End Date"
                        )
                    }
                }
                .disabled(/*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                .padding()
                .background()
                
                VStack(alignment: .leading, spacing: 24){
                    Text("Learning Time")
                        .foregroundStyle(.kTitleText)
                        .font(.body.bold())
                    
                    LearningTimeList(
                        items: vm.learningTimes
                    )
                }
                .padding()
                .background()
                
                Spacer()
            }
            .background(.kBackground)
            .navigationTitle("Goal")
            .navigationBarTitleDisplayMode(.inline)
            
        }
        .onAppear {
            vm.getPlanData()
            vm.getLearningTimes()
        }
    }
}

#Preview {
    GoalsScreen()
        .environmentObject(GoalViewModel())
}
