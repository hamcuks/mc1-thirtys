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
                .stroke(lineWidth: 35)
                .opacity(0.08)
                .foregroundStyle(Color.black)
                .frame(width: 261, height: 261)
            
            Circle()
                .trim(from: 0, to: progress)
                .stroke(style: StrokeStyle(lineWidth: 35, lineCap: .round, lineJoin: .round))
                .rotationEffect(Angle(degrees: 270))
                .foregroundStyle(Color.kAccent)
                .frame(width: 261, height: 261)
        }
        .padding()
    }
}

#Preview {
    CircularProgressBar(progress: 0.1)
}
