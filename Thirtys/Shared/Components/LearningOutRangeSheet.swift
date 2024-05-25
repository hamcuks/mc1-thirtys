//
//  LearningOutRangeSheet.swift
//  Thirtys
//
//  Created by Rajesh Triadi Noftarizal on 25/05/24.
//

import SwiftUI

struct LearningOutOfRangeSheet: View {
    @Binding var showOutOfRangeOptions: Bool
    let startLearningAnyway: () -> Void
    
    var body: some View {
        VStack(spacing: 24) {
            VStack(spacing: 16) {
                Text("You are not within your scheduled learning time!")
                    .font(.system(.body, weight: .bold))
            }
            
            HStack(spacing: 12) {
                Button("Cancel") {
                    showOutOfRangeOptions = false
                }
                .font(.system(.caption, weight: .bold))
                .frame(width: 164, height: 41)
                .foregroundColor(Color.kLabel)
                .background(Color.kAccent)
                .cornerRadius(45)
                
                Button("Learn Anyway") {
                    showOutOfRangeOptions = false
                    startLearningAnyway()
                }
                .frame(width: 164, height: 41)
                .font(.system(.caption, weight: .bold))
                .foregroundColor(Color.kLabel)
                .background(Color.kAccent)
                .cornerRadius(45)
            }
        }
        .presentationDetents([.fraction(0.25)])
        .interactiveDismissDisabled()
        .padding()
    }
}

#Preview {
    LearningOutOfRangeSheet(showOutOfRangeOptions: .constant(true)) {
    }
}
