//
//  AppDatePicker.swift
//  Thirtys
//
//  Created by Ivan Nur Ilham Syah on 20/05/24.
//

import SwiftUI

struct AppDatePicker: View {
    
    @Binding var selection: Date
    
    var label: String
    var placeholder: String = "Select Date"
    
    @State private var isOpened: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8){
            Text("\(label)")
                .font(.subheadline)
                .bold()
                .foregroundStyle(.kTitleText)
            
            HStack {
                Text(selection, style: .date)
                    .fontWeight(.medium)
                
                Spacer()
                
                Image(systemName: "calendar")
                    .onTapGesture {
                        isOpened.toggle()
                    }
                
            }
            .foregroundStyle(.kTitleText)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(16)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.kAccent, lineWidth: 2)
            )
            
        }
        .sheet(isPresented: $isOpened) {
            VStack(spacing: 24){
                DatePicker("", selection: $selection, displayedComponents: .date)
                    .datePickerStyle(.graphical)
                
                Button("Set") {
                    isOpened.toggle()
                }.buttonStyle(AppButtonStyle())
            }
            .presentationDetents([.medium])
            .padding()
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Text("Save")
                }
            }
            
        }
    }
}



#Preview {
    AppDatePicker(selection: .constant(.now), label: "Label")
}
