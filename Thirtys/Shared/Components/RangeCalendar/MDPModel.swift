//
//  MDPModel.swift
//  Thirtys
//
//  Created by Rajesh Triadi Noftarizal on 26/05/24.
//

import Foundation
import SwiftUI
import Combine

class MDPModel: NSObject, ObservableObject {
    public var controlDate: Date = Date() {
        didSet {
            buildDays()
        }
    }
    @Published var days = [MDPDayOfMonth]()
    @Published var title = ""
    @Published var selections = [Date]()
    
    // the localized days of the week
    let dayNames = Calendar.current.shortWeekdaySymbols
    
    // MARK: - PRIVATE VARS
    private var dateRangeWrapper: Binding<ClosedRange<Date>?>?
    private var minDate: Date? = nil
    private var maxDate: Date? = nil
    var numDays = 0
    
    // MARK: - INIT
    
    convenience init(dateRange: Binding<ClosedRange<Date>?>,
                     minDate: Date?,
                     maxDate: Date?) {
        self.init()
        self.dateRangeWrapper = dateRange
        self.minDate = minDate
        self.maxDate = maxDate
        setSelection(dateRange.wrappedValue)
        
        // set the selection to be the first in the range if the range exists
        if let dateRange = dateRange.wrappedValue {
            controlDate = dateRange.lowerBound
        }
        buildDays()
    }
    
    func dayOfMonth(byDay: Int) -> MDPDayOfMonth? {
        guard 1 <= byDay && byDay <= 31 else { return nil }
        for dom in days {
            if dom.day == byDay {
                return dom
            }
        }
        return nil
    }
    
    func selectDay(_ day: MDPDayOfMonth) {
        guard day.isSelectable else { return }
        guard let date = day.date else { return }
        
        if selections.count != 1 {
            selections = [date]
        } else {
            selections.append(date)
        }
        selections.sort()
        if selections.count == 2 {
            dateRangeWrapper?.wrappedValue = selections[0]...selections[1]
        } else {
            dateRangeWrapper?.wrappedValue = nil
        }
    }
    
    func isSelected(_ day: MDPDayOfMonth) -> Bool {
        guard day.isSelectable else { return false }
        guard let date = day.date else { return false }
        
        if selections.isEmpty {
            return false
        } else if selections.count == 1 {
            return isSameDay(date1: selections[0], date2: date)
        } else {
            let range = selections[0]...selections[1]
            return range.contains(date)
        }
    }
    
    func isStartOrEndDate(_ day: MDPDayOfMonth) -> Bool {
        guard let date = day.date else { return false }
        return selections.first == date || selections.last == date
    }
    
    func incrMonth() {
        let calendar = Calendar.current
        if let newDate = calendar.date(byAdding: .month, value: 1, to: controlDate) {
            controlDate = newDate
        }
    }
    
    func decrMonth() {
        let calendar = Calendar.current
        if let newDate = calendar.date(byAdding: .month, value: -1, to: controlDate) {
            controlDate = newDate
        }
    }
    
    func show(month: Int, year: Int) {
        let calendar = Calendar.current
        let components = DateComponents(year: year, month: month, day: 1)
        if let newDate = calendar.date(from: components) {
            controlDate = newDate
        }
    }
}

extension MDPModel {
    private func buildDays() {
        let calendar = Calendar.current
        let year = calendar.component(.year, from: controlDate)
        let month = calendar.component(.month, from: controlDate)
        
        let dateComponents = DateComponents(year: year, month: month)
        let date = calendar.date(from: dateComponents)!
        
        let range = calendar.range(of: .day, in: .month, for: date)!
        let numDays = range.count
        
        let ord = calendar.component(.weekday, from: date)
        var index = 0
        
        let today = Date()
        
        // create an empty int array
        var daysArray = [MDPDayOfMonth]()
        
        // for 0 to ord, set the value in the array[index] to be 0, meaning no day here.
        for _ in 1..<ord {
            daysArray.append(MDPDayOfMonth(index: index, day: 0))
            index += 1
        }
        
        // for index in range, create a DayOfMonth that will represent one of the days
        // in the month. This object needs to be told if it is eligible for selection
        // which is based on the min/max dates if present.
        for i in 0..<numDays {
            let realDate = calendar.date(from: DateComponents(year: year, month: month, day: i+1))
            var dom = MDPDayOfMonth(index: index, day: i+1, date: realDate)
            dom.isToday = isSameDay(date1: today, date2: realDate)
            dom.isSelectable = isEligible(date: realDate)
            daysArray.append(dom)
            index += 1
        }
        
        // if index is not a multiple of 7, then append 0 to array until the next 7 multiple.
        let total = daysArray.count
        var remainder = 42 - total
        if remainder < 0 {
            remainder = 42 - total
        }
        
        for _ in 0..<remainder {
            daysArray.append(MDPDayOfMonth(index: index, day: 0))
            index += 1
        }
        
        self.numDays = numDays
        self.title = "\(calendar.monthSymbols[month-1]) \(year)"
        self.days = daysArray
    }
}

extension MDPModel {
    private func setSelection(_ dateRange: ClosedRange<Date>?) {
        if let dateRange = dateRange {
            selections = [dateRange.lowerBound, dateRange.upperBound]
        }
    }
    
    private func isSameDay(date1: Date?, date2: Date?) -> Bool {
        guard let date1 = date1, let date2 = date2 else { return false }
        let day1 = Calendar.current.component(.day, from: date1)
        let day2 = Calendar.current.component(.day, from: date2)
        let year1 = Calendar.current.component(.year, from: date1)
        let year2 = Calendar.current.component(.year, from: date2)
        let month1 = Calendar.current.component(.month, from: date1)
        let month2 = Calendar.current.component(.month, from: date2)
        return (day1 == day2) && (month1 == month2) && (year1 == year2)
    }
    
    private func isEligible(date: Date?) -> Bool {
        guard let date = date else { return true }
                
        if let minDate = minDate, let maxDate = maxDate {
            return (minDate...maxDate).contains(date)
        } else if let minDate = minDate {
            return date >= minDate
        } else if let maxDate = maxDate {
            return date <= maxDate
        }
        
        return true
    }
}
