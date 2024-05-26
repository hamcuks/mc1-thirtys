//
//  TimerIntent.swift
//  Thirtys
//
//  Created by Ivan Nur Ilham Syah on 26/05/24.
//

import Foundation
import AppIntents

struct PauseButtonIntent: LiveActivityIntent {
    static var title: LocalizedStringResource = "Pause LA"
    
    
    func perform() async throws -> some IntentResult {
        await MainActor.run {
            NotificationCenter.default.post(name: Notification.Name.pauseTimer, object: "Pause Timer")
        }
        print("Perform pause intent")
        return .result()
    }
    
}

struct ResumeButtonIntent: LiveActivityIntent {
    static var title: LocalizedStringResource = "Resume LA"
    
    
    func perform() async throws -> some IntentResult {
        await MainActor.run {
            NotificationCenter.default.post(name: Notification.Name.resumeTimer, object: "Resume Timer")
        }
        print("Perform pause intent")
        return .result()
    }
    
}

struct StopButtonIntent: LiveActivityIntent {
    static var title: LocalizedStringResource = "Stop LA"
    
    
    func perform() async throws -> some IntentResult {
        await MainActor.run {
            NotificationCenter.default.post(name: Notification.Name.stopTimer, object: "Stop Timer")
        }
        print("Perform pause intent")
        return .result()
    }
    
}
