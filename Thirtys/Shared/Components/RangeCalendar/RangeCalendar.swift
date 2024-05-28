//
//  CV.swift
//  Thirtys
//
//  Created by Rajesh Triadi Noftarizal on 26/05/24.
//

import SwiftUI

struct RangeCalendar: View {
    @State private var dateRange: ClosedRange<Date>? = nil
    @EnvironmentObject var onboardingViewModel: OnboardingViewModel
    
    var body: some View {
        VStack {
            MDP(dateRange: self.$dateRange)
        }
        .onChange(of: self.dateRange) { dateRange in
            print("Range selected: \(String(describing: dateRange))")
            if let range = dateRange {
                onboardingViewModel.planStartDate = range.lowerBound
                onboardingViewModel.planEndDate = range.upperBound
                print("Start Date: \(range.lowerBound)")
                print("End Date: \(range.upperBound)")
            }
        }
    }
}

#Preview(body: {
    RangeCalendar().environmentObject(OnboardingViewModel())
})
