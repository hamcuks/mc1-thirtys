//
//  LearningHistory.swift
//  Thirtys
//
//  Created by Bayu Septyan Nur Hidayat on 22/05/24.
//

import SwiftUI

struct LearningHistory: View {
    
    var historyLearning: [CountdownTimer]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 24){
            Text("Learning History")
                .font(.system(.body, weight: .bold))
                .frame(maxWidth: .infinity, alignment: .leading)
            
            if historyLearning.count > 0 {
                VStack(spacing: 16){
                    ForEach(historyLearning, id: \.id){ session in
                        HStack{
                            Text("\(Int(session.duration / 60)) minutes")
                                .frame(maxWidth: .infinity,alignment: .leading)
                                .font(.system(.subheadline, weight: .semibold))
                            
                            Text("\(session.startTime, style: .time) - \(session.endTime, style: .time)")
                                .frame(maxWidth: .infinity,alignment: .trailing)
                                .font(.system(.subheadline, weight: .semibold))
                        }
                        .padding(16)
                        .frame(maxWidth: .infinity, maxHeight: 50, alignment: .trailing)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.kAccent, lineWidth: 2)
                        )
                    }
                }
            } else {
                LearningHistoryEmpty()
                    .frame(width: .infinity, height: 94)
            }
            
            
        }
        .foregroundColor(Color.kTitleText)
        .padding([.horizontal, .vertical], 20)
        .frame(maxWidth: .infinity)
        .background(.white)
    }
}



#Preview {
    LearningHistory(historyLearning: CountdownTimerViewModel().learningHistory)
        .environmentObject(CountdownTimerViewModel())
}
