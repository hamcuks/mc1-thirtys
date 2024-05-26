//
//  ContentView.swift
//  Thirtys
//
//  Created by Rajesh Triadi Noftarizal on 26/05/24.
//

import SwiftUI

struct CV: View {

    @State private var dateRange: ClosedRange<Date>? = nil
    
    var body: some View {
        VStack {
            Text("Date Range").font(.title).padding()
            MultiDatePicker(dateRange: self.$dateRange)
            if let range = dateRange {
                Text("\(range)").padding()
            } else {
                Text("Select two dates").padding()
            }
        }
        .onChange(of: self.dateRange) { dateRange in
            print("Range selected: \(String(describing: dateRange))")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CV()
    }
}
