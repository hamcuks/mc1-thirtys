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
        VStack {
            Text("You are not within your scheduled learning time.")
                .font(.headline)
                .padding()
            
            HStack {
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
        .padding()
    }
}

#Preview {
    LearningOutOfRangeSheet(showOutOfRangeOptions: .constant(true)) {
    }
}
