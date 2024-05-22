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
}
