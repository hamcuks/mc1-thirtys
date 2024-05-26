//
//  LearningTimerAttributes.swift
//  Thirtys
//
//  Created by Ivan Nur Ilham Syah on 26/05/24.
//

import Foundation
import ActivityKit

struct LearningTimerAttributes: ActivityAttributes {
    public typealias TimerStatus = ContentState
    
    public struct ContentState: Codable, Hashable {
        var pauseTime: TimeInterval?
    }
    
    var countdownInterval: TimeInterval
}
