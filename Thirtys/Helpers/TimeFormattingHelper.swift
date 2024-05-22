//
//  TimeFormattingHelper.swift
//  Thirtys
//
//  Created by Rajesh Triadi Noftarizal on 22/05/24.
//

import Foundation

func timeString(from timeInterval: TimeInterval) -> String {
    let minutes = Int(timeInterval) / 60
    let seconds = Int(timeInterval) % 60
    return String(format: "%02d:%02d", minutes, seconds)
}
