//
//  MDPMonthView.swift
//  Thirtys
//
//  Created by Rajesh Triadi Noftarizal on 26/05/24.
//

import SwiftUI

struct MDPMonthView: View {
    @EnvironmentObject var monthDataModel: MDPModel
    
    @State private var showMonthYearPicker = false
    
    private func showPrevMonth() {
        withAnimation {
            monthDataModel.decrMonth()
            showMonthYearPicker = false
        }
    }
    
    private func showNextMonth() {
        withAnimation {
            monthDataModel.incrMonth()
            showMonthYearPicker = false
        }
    }
    
    var body: some View {
        VStack {
            HStack {
                MDPMonthYearPickerButton(isPresented: self.$showMonthYearPicker)
                Spacer()
                Button(action: { showPrevMonth() }) {
                    Image(systemName: "chevron.left").font(.title2)
                }
                .padding(.trailing)
                Button(action: { showNextMonth() }) {
                    Image(systemName: "chevron.right").font(.title2)
                }
                .padding(.leading)
            }
            .padding()
            
            GeometryReader { reader in
                if showMonthYearPicker {
                    MDPMonthYearPicker(date: monthDataModel.controlDate) { (month, year) in
                        self.monthDataModel.show(month: month, year: year)
                    }
                } else {
                    MDPContentView()
                }
            }
        }
        .background(
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(.white)
        )
//        .overlay(
//            RoundedRectangle(cornerRadius: 10)
//                .stroke(Color.accentColor, lineWidth: 1)
//        )
//        .padding()
//        .frame(width: 500, height: 300)
    }
}

struct MonthView_Previews: PreviewProvider {
    static var previews: some View {
        MDPMonthView()
            .environmentObject(MDPModel(dateRange: .constant(nil), minDate: nil, maxDate: nil))
    }
}
