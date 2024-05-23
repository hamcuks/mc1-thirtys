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
                .font(.system(.caption, weight: .bold))
                .frame(width: 164, height: 41)
                
                .foregroundColor(Color.kLabel)
                .background(Color.kAccent)
                .cornerRadius(45)
                
                
                Button {
                    resetAction()
                    isConfirmationStopOpen.toggle()
                } label: {
                    Image(systemName: "flag.fill")
                    Text("Stop")
                }
                .frame(width: 164, height: 41)
                .font(.system(.caption, weight: .bold))
                .foregroundColor(Color.kError)
                .background(Color.kError.opacity(0.15))
                .cornerRadius(45)
            }
            
        }
        .presentationDetents([.fraction(0.25)])
        .interactiveDismissDisabled()
    }
}

//#Preview {
//    ConfirmationStopLearningComponent(isConfirmationStopOpen: .constant(true), resetAction: countdownTimerViewModel.resetTimer())
//}
