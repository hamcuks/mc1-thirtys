//
//  LearningHistoryEmpty.swift
//  Thirtys
//
//  Created by Bayu Septyan Nur Hidayat on 20/05/24.
//

import SwiftUI

struct LearningHistoryEmpty: View {
    var body: some View {
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
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    LearningHistoryEmpty()
}
