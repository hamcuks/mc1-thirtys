//
//  ConfirmationStopLearningComponent.swift
//  Thirtys
//
//  Created by Bayu Septyan Nur Hidayat on 23/05/24.
//

import SwiftUI

struct ConfirmationStopLearningComponent: View {
    
    @Binding var isConfirmationStopOpen: Bool
    var resetAction: () -> Void
    
    var body: some View {
        VStack(spacing: 24){
            VStack(spacing: 16){
                Text("Are you sure want to stop learning?")
                    .font(.system(.body, weight: .bold))
                Text("Your learning duration will be lost and it will not be recorded in your learning history.")
                    .font(.system(.subheadline, weight: .regular))
                    .multilineTextAlignment(.center)
            }
            
            HStack(spacing: 12){
                
                Button {
                    isConfirmationStopOpen.toggle()
                } label: {
                    Text("Cancel")
                }
                .buttonStyle(AppButtonStyle())
                
                
                Button {
                    resetAction()
                    isConfirmationStopOpen.toggle()
                } label: {
                    HStack {
                        Image(systemName: "flag.fill")
                        Text("Stop")
                    }
                }
                .buttonStyle(
                    AppButtonStyle(
                        backgroundColor: .kError.opacity(0.1),
                        foregroundColor: .kError
                    )
                )
            }
            
        }
        .padding(.horizontal)
        .presentationDetents([.fraction(0.25)])
        .interactiveDismissDisabled()
    }
}

//#Preview {
//    ConfirmationStopLearningComponent(isConfirmationStopOpen: .constant(true), resetAction: countdownTimerViewModel.resetTimer())
//}
