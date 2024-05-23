//
//  DailyStreak.swift
//  Thirtys
//
//  Created by Bayu Septyan Nur Hidayat on 22/05/24.
//

import SwiftUI

struct DailyStreak: View {
    
    let data = ["SUN", "MON", "TUE", "WED", "THU", "FRI", "SAT"]
    
    @State private var isDailyAchive: Bool = false
    
    var body: some View {
        
        HStack{
            Grid(horizontalSpacing: 28, verticalSpacing: 0){
                GridRow{
                    ForEach(data, id: \.hashValue) { i in
                        VStack{
                            Text("\(i)")
                                .font(.system(.caption2, weight: .semibold))
                                .foregroundStyle(Color.kBody)
                            //                                .padding(.bottom, 12)
                            if isDailyAchive{
                                Image("daily-achievement")
                                    .frame(maxWidth: 24)
                            } else {
                                Circle()
                                    .stroke(Color.kPlaceholder, lineWidth: 4)
                                    .frame(maxWidth: 24)
                            }
                        }
                    }
                }
            }
        }
        .frame(maxWidth: .infinity)
    }
}


#Preview {
    DailyStreak()
}
