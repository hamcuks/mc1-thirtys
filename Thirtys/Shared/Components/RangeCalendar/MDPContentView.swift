//
//  MDPContentView.swift
//  Thirtys
//
//  Created by Rajesh Triadi Noftarizal on 26/05/24.
//

import SwiftUI

struct MDPContentView: View {
    @EnvironmentObject var monthDataModel: MDPModel
    
    func calculateRows() -> Int {
        let daysCount = monthDataModel.days.count
        return (daysCount / 7) + (daysCount % 7 == 0 ? 0 : 1)
    }
    
    var body: some View {
        let rows = calculateRows()
        let cellSize: CGFloat = 50
        let rowSpacing: CGFloat = rows == 5 ? 10 : 5
        let columns = Array(repeating: GridItem(.fixed(cellSize), spacing: 5), count: 7)
        
        LazyVGrid(columns: columns, spacing: rowSpacing) {
            ForEach(0..<monthDataModel.dayNames.count, id: \.self) { index in
                Text(monthDataModel.dayNames[index].uppercased())
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .padding(.bottom, 10)
            
            ForEach(0..<monthDataModel.days.count, id: \.self) { index in
                if monthDataModel.days[index].day == 0 {
                    Text("")
                        .frame(width: cellSize, height: cellSize)
                } else {
                    MDPDayView(dayOfMonth: monthDataModel.days[index])
                        .padding(5)
                }
            }
        }
        .padding(.all, 10)
    }
}

struct MonthContentView_Previews: PreviewProvider {
    static var previews: some View {
        MDPContentView()
            .environmentObject(MDPModel())
    }
}
