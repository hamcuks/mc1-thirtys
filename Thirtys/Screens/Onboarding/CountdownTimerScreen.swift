//
//  CountdownTimerScreen.swift
//  Thirtys
//
//  Created by Rajesh Triadi Noftarizal on 22/05/24.
//

import SwiftUI

struct CountdownTimerScreen: View {
    @StateObject private var viewModel = CountdownTimerViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Belajar Swift 1 Bulan")
                    .font(.title)
                    .padding()
                
                Text("Your learning time is available at 06.00 - 07.30")
                    .font(.subheadline)
                
                ZStack {
                    CircularProgressBar(progress: CGFloat(viewModel.remainingTime / 1800))
                        .padding()
                    
                    
                    VStack {
                        Text("\(timeString(from: viewModel.remainingTime))")
                            .font(.system(size: 36))
                            .bold()
                            .foregroundStyle(Color.kLabel)
                            .contentTransition(.numericText())
                        Text("Remaining")
                            .font(.system(size: 16))
                            .bold()
                            .foregroundStyle(Color.kPlaceholder)
                    }
                }
                
                HStack {
                    Button(action: {
                        if viewModel.isActive {
                            viewModel.pauseTimer()
                        } else {
                            viewModel.startTimer()
                        }
                    }) {
                        Text(viewModel.isActive ? "Pause" : "Start Learning")
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    
                    Button(action: {
                        viewModel.resetTimer()
                    }) {
                        Text("Surrender")
                            .padding()
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
                .padding()
                
                VStack(alignment: .leading, spacing: 24) {
                    Text("Learning History")
                        .font(.system(.body, weight: .bold))
                        .frame(maxWidth: .infinity,alignment: .leading)
                }
                
                List(viewModel.learningHistory, id: \.id) { session in
                    HStack {
                        Text("\(Int(session.duration / 60)) minutes")
                        Spacer()
                        Text("\(session.startTime, style: .time) - \(session.endTime, style: .time)")
                    }
                }
            }
            .padding()
        }
    }
}

#Preview {
    CountdownTimerScreen()
}

