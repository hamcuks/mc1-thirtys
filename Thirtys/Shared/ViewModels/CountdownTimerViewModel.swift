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
    @Published var hasStarted: Bool = false
    
    private var timer: AnyCancellable?
    private var startTime: Date?
    private let lastCheckedDateKey = "lastCheckedDate"
    
    // Initialize and check if it's a new day
    init() {
        checkForNewDay()
    }
    
    // Start the countdown timer
    func startTimer() {
        isActive = true
        hasStarted = true
        startTime = Date() // Record the start time
        timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect().sink { _ in
            self.remainingTime -= 1
            if self.remainingTime <= 0 {
                self.completeSession()
            }
        }
    }
    
    // Pause the countdown timer
    func pauseTimer() {
        isActive = false
        timer?.cancel()
        recordSession()
    }
    
    // Reset the countdown timer
    func resetTimer() {
        remainingTime = 1800
        isActive = false
        hasStarted = false
        timer?.cancel()
        startTime = nil
        learningHistory.removeAll()
        saveLastCheckedDate()
    }
    
    // Complete the current session
    func completeSession() {
        isActive = false
        timer?.cancel()
        recordSession()
    }
    
    // Record the current session
    func recordSession() {
        if let start = startTime {
            let endTime = Date()
            let session = CountdownTimer(startTime: start, endTime: endTime, duration: 1800 - remainingTime)
            learningHistory.append(session)
        }
    }
    
    // Save the current date as the last checked date
    func saveLastCheckedDate() {
        UserDefaults.standard.set(Date(), forKey: lastCheckedDateKey)
    }
    
    // Retrieve the last checked date
    func getLastCheckedDate() -> Date? {
        UserDefaults.standard.object(forKey: lastCheckedDateKey) as? Date
    }
    
    // Check if it's a new day and reset the timer if needed
    func checkForNewDay() {
        if let lastChecked = getLastCheckedDate() {
            if !Calendar.current.isDateInToday(lastChecked) {
                resetTimer()
            }
        } else {
            saveLastCheckedDate()
        }
    }
}
