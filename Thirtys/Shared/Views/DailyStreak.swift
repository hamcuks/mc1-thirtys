//
//  DailyStreak.swift
//  Thirtys
//
//  Created by Bayu Septyan Nur Hidayat on 22/05/24.
//

import SwiftUI

struct DailyStreak: View {
    
    @EnvironmentObject private var vm: TodayViewModel
    
    @State private var isDailyAchive: Bool = false
    
    var body: some View {
        
        HStack{
            
            ForEach(vm.weekdays, id: \.hashValue) { day in
                Spacer()
                VStack{
                    Text("\(day.formatted(.dateTime.weekday()))")
                        .font(.system(.caption2, weight: .semibold))
                        .foregroundStyle(Color.kBody)
                    
                    if vm.weeklyStreaks.contains(where: { streakDate in Calendar.current.isDate(streakDate, equalTo: day, toGranularity: .day) }){
                        Image("daily-achievement")
                            .frame(maxWidth: 24)
                        
                    } else {
                        Circle()
                            .stroke(Color.kPlaceholder, lineWidth: 4)
                            .frame(maxWidth: 24)
                    }
                }
                Spacer()
            }
            
        }
        .frame(maxWidth: .infinity)
        .padding(.top)
    }
}


#Preview {
    DailyStreak()
        .environmentObject(TodayViewModel())
}
