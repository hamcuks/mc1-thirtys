//
//  DateExtension.swift
//  Thirtys
//
//  Created by Ivan Nur Ilham Syah on 21/05/24.
//

import Foundation

extension Date {
    func addMinute(to: Int) -> Date {
        let calendar = Calendar.current
        return calendar.date(
            byAdding: .minute,
            value: to,
            to: self
        )!
    }
    
    var minTime: Date {
        Calendar.current.date(bySettingHour: 00, minute: 00, second: 00, of: self)!
    }
    
    var maxTime: Date {
        Calendar.current.date(bySettingHour: 23, minute: 59, second: 59, of: self)!
    }
}
