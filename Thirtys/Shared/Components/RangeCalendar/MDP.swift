//
//  MultiDatePicker.swift
//  Thirtys
//
//  Created by Rajesh Triadi Noftarizal on 26/05/24.
//

import SwiftUI

struct MDP: View {
    
    @StateObject var monthModel: MDPModel
    
    init(dateRange: Binding<ClosedRange<Date>?>,
         minDate: Date? = nil,
         maxDate: Date? = nil
    ) {
        _monthModel = StateObject(wrappedValue: MDPModel(dateRange: dateRange, minDate: minDate, maxDate: maxDate))
    }
    
    var body: some View {
        MDPMonthView()
            .environmentObject(monthModel)
    }
}

struct MultiDatePicker_Previews: PreviewProvider {
    @State static var dateRange: ClosedRange<Date>? = nil
    
    static var previews: some View {
        ScrollView {
            VStack {
                MDP(dateRange: $dateRange)
            }
        }
    }
}
