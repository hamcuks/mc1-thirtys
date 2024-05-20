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
            Label("", systemImage: "calendar.day.timeline.leading")
                .font(.system(.subheadline, weight: .semibold))
                .padding(.bottom, -16)
                
        } description: {
        Text("You haven't completed your learning session today!")
        }
        .frame(maxWidth: .infinity, maxHeight: 156)
        .padding(.bottom, -25)
    }
}

#Preview {
    LearningHistoryEmpty()
}
