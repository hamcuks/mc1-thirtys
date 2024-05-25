//
//  LearningHistory.swift
//  Thirtys
//
//  Created by Bayu Septyan Nur Hidayat on 22/05/24.
//

import SwiftUI

struct LearningHistory: View {
    
    var historyLearning: [Event]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 24){
            Text("Learning History")
                .font(.system(.body, weight: .bold))
                .frame(maxWidth: .infinity, alignment: .leading)
            
            if historyLearning.count > 0 {
                VStack(spacing: 16){
                    ForEach(historyLearning, id: \.hashValue){ session in
                        HStack{
                            Text("\(Int((session.duration ?? 0) / 60)) minutes")
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
                ContentUnavailableView{
                    Label {
                        // Put the "text" here
                        Text("")
                    } icon: {
                        // Put the "image" here
                        Image(systemName: "calendar.day.timeline.leading")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20)
                    }
                    .font(.system(.subheadline, weight: .semibold))
                    .padding(.bottom, -20)
                    
                } description: {
                    Text("You have no learning history!")
                        .font(.system(.footnote,weight: .medium))
                }
            }
            
            
        }
        .foregroundColor(Color.kTitleText)
        .padding([.horizontal, .vertical], 20)
        .frame(maxWidth: .infinity)
        .background(.white)
    }
}



#Preview {
    LearningHistory(historyLearning: [])
}
