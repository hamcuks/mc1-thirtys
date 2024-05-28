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
        VStack(alignment: .leading, spacing: 24) {
            VStack(spacing: 16){
                Text("There is no active learning time!")
                    .font(.system(.body, weight: .bold))
                Text("You are not within your scheduled learning time. Do you still want to learn?")
                    .font(.system(.subheadline, weight: .regular))
                    .multilineTextAlignment(.center)
            }
            
            
            HStack(spacing: 12) {
                Button("Cancel") {
                    showOutOfRangeOptions = false
                }
                .buttonStyle(AppButtonStyle())
                
                Button("Learn Anyway") {
                    showOutOfRangeOptions = false
                    startLearningAnyway()
                }
                .buttonStyle(AppButtonStyle())
            }
        }
        .presentationDetents([.fraction(0.25)])
        .interactiveDismissDisabled()
        .padding(.horizontal)
    }
}

#Preview {
    LearningOutOfRangeSheet(showOutOfRangeOptions: .constant(true)) {
    }
}
