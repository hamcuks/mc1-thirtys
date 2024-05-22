//
//  CountdownTimerViewModel.swift
//  Thirtys
//
//  Created by Rajesh Triadi Noftarizal on 22/05/24.
//

import SwiftUI
import Combine

class CountdownTimerViewModel: ObservableObject {
    @Published var remainingTime: TimeInterval = 1800 // 30 minutes in seconds
    @Published var isActive: Bool = false
    @Published var learningHistory: [CountdownTimer] = []
    
    private var timer: AnyCancellable?
    private var startTime: Date?
    
    func startTimer() {
        isActive = true
        startTime = Date() // Record the start time
        timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect().sink { _ in
            self.remainingTime -= 1
            if self.remainingTime <= 0 {
                self.completeSession()
            }
        }
    }
    
    func pauseTimer() {
        isActive = false
        timer?.cancel()
        if let start = startTime {
            let endTime = Date()
            let session = CountdownTimer(startTime: start, endTime: endTime, duration: 1800 - remainingTime)
            learningHistory.append(session)
        }
    }
    
    func resetTimer() {
        remainingTime = 1800
        isActive = false
        timer?.cancel()
        startTime = nil
    }
    
    func completeSession() {
        isActive = false
        timer?.cancel()
        if let start = startTime {
            let endTime = Date()
            let session = CountdownTimer(startTime: start, endTime: endTime, duration: 1800 - remainingTime)
            learningHistory.append(session)
        }
    }
}
