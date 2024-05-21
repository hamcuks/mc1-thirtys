//
//  TimePickerComponent.swift
//  Thirtys
//
//  Created by Ivan Nur Ilham Syah on 21/05/24.
//

import SwiftUI

struct TimePickerFrom: View {
    @State private var isOpen: Bool = false
    
    var label: String
    var selection: Binding<Date>
    var range: PartialRangeFrom<Date>
    
    init(
        label: String,
        selection: Binding<Date>,
        in timeRange: PartialRangeFrom<Date>
    ) {
        self.label = label
        self.selection = selection
        self.range = timeRange
    }
    
    var body: some View {
        HStack {
            Text(label)
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundStyle(.kTitleText)
            
            Spacer()
            
            HStack {
                
                Text(selection.wrappedValue, style: .time)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                
                Image(
                    systemName: "pencil"
                )
                
            }
            .bold()
            .foregroundStyle(.kSuccess)
            .onTapGesture {
                isOpen.toggle()
            }
        }
        .padding(16)
        .frame(maxWidth: .infinity)
        .overlay {
            RoundedRectangle(cornerRadius: 8)
                .strokeBorder(
                    .kAccent, lineWidth: 1.5
                )
        }
        .sheet(isPresented: $isOpen) {
            VStack {
                
                Spacer()
                Text("Set Up Work Time Range")
                    .fontWeight(.semibold)
                    .font(.title3)
                
                DatePicker(
                    "",
                    selection: selection,
                    in: range,
                    displayedComponents: [.hourAndMinute]
                )
                .datePickerStyle(.wheel)
                .labelsHidden()
                
                Spacer()
                
                Button("Set") {
                    isOpen.toggle()
                }.buttonStyle(AppButtonStyle())
            }
            .padding()
            .presentationDetents([.medium])
        }
    }
}

struct TimePickerThrough: View {
    @State private var isOpen: Bool = false
    
    var label: String
    var selection: Binding<Date>
    var range: PartialRangeThrough<Date>
    
    init(
        label: String,
        selection: Binding<Date>,
        in timeRange: PartialRangeThrough<Date>
    ) {
        self.label = label
        self.selection = selection
        self.range = timeRange
    }
    
    var body: some View {
        HStack {
            Text(label)
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundStyle(.kTitleText)
            
            Spacer()
            
            HStack {
                
                Text(selection.wrappedValue, style: .time)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                
                Image(
                    systemName: "pencil"
                )
                
            }
            .bold()
            .foregroundStyle(.kSuccess)
            .onTapGesture {
                isOpen.toggle()
            }
        }
        .padding(16)
        .frame(maxWidth: .infinity)
        .overlay {
            RoundedRectangle(cornerRadius: 8)
                .strokeBorder(
                    .kAccent, lineWidth: 1.5
                )
        }
        .sheet(isPresented: $isOpen) {
            VStack {
                
                Spacer()
                Text("Set Up Work Time Range")
                    .fontWeight(.semibold)
                    .font(.title3)
                
                DatePicker(
                    "",
                    selection: selection,
                    in: range,
                    displayedComponents: [.hourAndMinute]
                )
                .datePickerStyle(.wheel)
                .labelsHidden()
                
                Spacer()
                
                Button("Set") {
                    isOpen.toggle()
                }.buttonStyle(AppButtonStyle())
            }
            .padding()
            .presentationDetents([.medium])
        }
    }
}

#Preview {
    TimePickerFrom(
        label: "Start Time",
        selection: .constant(.now),
        in: Date.now...
    )
}
