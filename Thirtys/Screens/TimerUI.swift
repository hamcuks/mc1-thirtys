//
//  TimerUI.swift
//  Thirtys
//
//  Created by DwikySP on 20/05/24.
//

import SwiftUI

extension TimeInterval {
    func format(using units: NSCalendar.Unit) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = units
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad
        return formatter.string(from: self) ?? ""
    }
}
struct CircleTimer: View {
    
    @Binding var progress: Double
    @Binding var duration: TimeInterval
    
    var body: some View {
        VStack{
            Text("Belajar Swift 1 Bulan")
                .font(.system(size: 22).bold())
                .foregroundColor(Color.kTitleText)
            Text("Your learning time is available at 06.00 - 07.30")
                .font(.system(size: 14))
                .foregroundColor(Color.kLabel)
            ZStack {
                Circle()
                    .stroke(lineWidth: 35)
                    .opacity(0.08)
                    .foregroundColor(.black)
                    .frame(width: 261, height: 261)
                
                Circle()
                    .trim(from: 0.0, to: progress)
                    .stroke(style: StrokeStyle(lineWidth: 35, lineCap: .round, lineJoin: .round))
                    .rotationEffect(.degrees(270.0))
                    .foregroundColor(Color.kAccent)
                    .frame(width: 261, height: 261)
                
                VStack {
                    Text(duration.format(using: [.minute, .second]))
                        .font(.system(size: 36).bold())
                        .foregroundColor(Color.kLabel)
                        .contentTransition(.numericText())
                    Text("Remaining")
                        .font(.system(size: 24).bold())
                        .foregroundColor(Color.kPlaceholder)
                }
            }
            .padding()
            .padding()
            Button {
            } label: {
                Image(systemName: "play.fill")
                Text("Start Learning")
            }.frame(width: 351, height: 41)
                .font(.system(size:14).bold())
                .foregroundColor(Color.kLabel)
                .background(Color.kAccent)
                .cornerRadius(45)
        }
    }
    
}


struct CircleTimer_Previews: PreviewProvider {
    static var previews: some View {
        CircleTimer(progress: .constant(1), duration: .constant(1800))
    }
}
