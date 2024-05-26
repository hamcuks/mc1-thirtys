//
//  NotificationExtension.swift
//  Thirtys
//
//  Created by Ivan Nur Ilham Syah on 26/05/24.
//

import Foundation

extension Notification.Name {
    static let stopTimer = Notification.Name("StopTimerForLiveActivity")
    static let resumeTimer = Notification.Name("ResumeTimerForLiveActivity")
    static let pauseTimer = Notification.Name("PauseTimerForLiveActivity")
}
