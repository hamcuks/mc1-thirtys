//
//  MultiRangeDatePicker.swift
//  Thirtys
//
//  Created by Bayu Septyan Nur Hidayat on 19/05/24.
//

import SwiftUI

struct MultiRangeDatePicker: View {
    
    @State private var isConfirmationSheetOpen: Bool = true
    @State private var dates: Set<DateComponents> = []
    @State private var coba: String = "Choose your range schedule"
    var uiColor = UIColor(red: 0.52, green: 0.86, blue: 0.78, alpha: 1.00)
    
    var titleColor = UIColor(red: 0.02, green: 0.25, blue: 0.20, alpha: 1.00)
    
    
    var body: some View {
        VStack(alignment: .leading){
            MultiDatePicker("Dates", selection: $dates, in: Date()...)
            
                .datePickerStyle(.graphical)
                .tint(Color(uiColor: titleColor))
                .clipped()
        }
        
    }
}

#Preview {
    MultiRangeDatePicker()
}
