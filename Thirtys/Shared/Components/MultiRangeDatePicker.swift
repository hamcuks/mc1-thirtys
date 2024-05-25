//
//  MultiRangeDatePicker.swift
//  Thirtys
//
//  Created by Bayu Septyan Nur Hidayat on 19/05/24.
//

import SwiftUI

struct MultiRangeDatePicker: View {
    var dates: Set<DateComponents>
    
    var body: some View {
        VStack(alignment: .leading){
            MultiDatePicker("Dates", selection: .constant(dates))
                .datePickerStyle(.graphical)
                .tint(.orange)
                .foregroundStyle(.kAccent)
        }
        
    }
}

#Preview {
    MultiRangeDatePicker(dates: [])
}
