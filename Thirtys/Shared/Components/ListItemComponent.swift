//
//  ListItemComponent.swift
//  Thirtys
//
//  Created by Ivan Nur Ilham Syah on 20/05/24.
//

import SwiftUI

struct ListItemComponent: View {
    @Binding var data: Weekday
    @State private var isOpen: Bool = false
    
    var body: some View {
        HStack {
            Text(data.label.term)
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundStyle(.kTitleText)
            
            Spacer()
            
            HStack {

                if data.isDayOff {
                    Text("Set Up")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                } else {
                    (
                        Text(data.event.startTime, style: .time) +
                        Text(" - ") +
                        Text(data.event.endTime, style: .time)
                    )
                        .font(.subheadline)
                        .fontWeight(.semibold)
                }
                    
                Image(
                    systemName: data.isDayOff ? "chevron.forward" : "pencil"
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
            VStack(spacing: 24) {
                Text("Set Up Work Time Range")
                    .fontWeight(.semibold)
                    .font(.title3)
                
                DatePicker(
                    "Start Time",
                    selection: $data.event.startTime,
                    displayedComponents: .hourAndMinute
                )
                DatePicker(
                    "End Time",
                    selection: $data.event.endTime,
                    in: data.event.startTime...,
                    displayedComponents: .hourAndMinute
                )
                
                Spacer()
                
                Button("Set") {
                    isOpen.toggle()
                }
                .buttonStyle(AppButtonStyle())
            }
            .padding()
            .padding(.top, 24)
            .presentationDetents([.medium])
        }
    }
}

#Preview {
    ListItemComponent(
        data: .constant(Weekday.dummy)
    )
}
