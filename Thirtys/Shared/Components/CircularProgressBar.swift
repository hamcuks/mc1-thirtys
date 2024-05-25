//
//  CircularProgressBar.swift
//  Thirtys
//
//  Created by Rajesh Triadi Noftarizal on 22/05/24.
//

import SwiftUI

struct CircularProgressBar: View {
    var progress: CGFloat
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 20)
                .opacity(0.08)
                .foregroundStyle(Color.black)
                .frame(width: 261, height: 261)
            
            Circle()
                .trim(from: 0, to: progress)
                .stroke(style: StrokeStyle(lineWidth: 20, lineCap: .round, lineJoin: .round))
                .rotationEffect(Angle(degrees: 270))
                .foregroundStyle(Color.kAccent)
                .frame(width: 261, height: 261)
            
            Circle()
                .fill(Color.white)
                .frame(width: 240, height: 240)
                .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 5)
        }
        .animation(.easeInOut(duration: 1.5), value: progress)
    }
}

#Preview {
    CircularProgressBar(progress: 0.1)
}
