//
//  MultiRangeDatePicker.swift
//  Thirtys
//
//  Created by Bayu Septyan Nur Hidayat on 19/05/24.
//

import SwiftUI

struct MultiRangeDatePicker: View {
    
    @State private var isConfirmationSheetOpen: Bool = false
    @State private var dates: Set<DateComponents> = []
    @State private var coba: String = "Choose your range schedule"
    var uiColor = UIColor(red: 0.52, green: 0.86, blue: 0.78, alpha: 1.00)
    
    var titleColor = UIColor(red: 0.02, green: 0.25, blue: 0.20, alpha: 1.00)
    
    
    var body: some View {
        HStack {
            Text("Select dates:")
            Spacer()
            Button {
                isConfirmationSheetOpen.toggle()
            } label: {
                Text(coba)
            }
        }
        .datePickerStyle(.compact)
        .offset(y: 40)
        .padding(20)
        .sheet(isPresented: $isConfirmationSheetOpen) {
            Spacer()
            VStack(alignment: .leading){
                Text("Plan Duration")
                    .foregroundColor(Color(uiColor: uiColor))
                    .bold()
                    .font(.subheadline)
                    .padding(.leading, 10)

                    
                MultiDatePicker("Dates", selection: $dates, in: Date()...)
                    
                    .datePickerStyle(.compact)
                    .presentationDetents([.medium])
                    .padding(.vertical, -10)
                    .labelsHidden()
                    .tint(Color(uiColor: titleColor))
                    .preferredColorScheme(.light)
            }
            .frame(maxWidth: .infinity,alignment: .leading)
            
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color(uiColor: uiColor), lineWidth: 2)
            )
            .accentColor(Color(uiColor: uiColor))
            .padding()
            
        }
        .onChange(of: dates) { oldDates, newDates in
            if newDates.count == 2 {
                coba = getDateInterval(date: newDates)
                isConfirmationSheetOpen.toggle()
            } else if newDates.count > 2 {
                dates = []
                coba = "Choose your range schedule"
            }
        }
    }
}

func getDateInterval(date: Set<DateComponents>) -> String {
    let datesArr: [Date] = date.compactMap { Calendar.current.date(from: $0) }.sorted()
    
    if datesArr.count == 2 {
        let startDate = datesArr[0]
        let endDate = datesArr[1]
        
//        let monthDifference = Calendar.current.dateComponents([.month], from: startDate, to: endDate).month ?? 0
//        let weekDifference = Calendar.current.dateComponents([.weekOfYear], from: startDate, to: endDate).weekOfYear ?? 0
        
        // \n\(monthDifference) month(s) and \(weekDifference) week(s)
        
        return "\(startDate.formatted(date: .abbreviated, time: .omitted)) - \(endDate.formatted(date: .abbreviated, time: .omitted))"
    }
    
    return "none"
}

#Preview {
    MultiRangeDatePicker()
}
