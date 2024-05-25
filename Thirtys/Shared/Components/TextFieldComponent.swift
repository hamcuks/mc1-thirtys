//
//  TextFieldComponent.swift
//  Thirtys
//
//  Created by Bayu Septyan Nur Hidayat on 19/05/24.
//

import SwiftUI

struct AppTextField: View {
    
    //    @State private var firstShow: Bool = false
    @Binding var selection: String
    
    var label: String
    var placeholder: String = "Input value"
    //    var errorDesc: String
    let charTextLimit: Int = 40
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8){
            Text("\(label)")
                .font(.subheadline)
                .bold()
                .foregroundStyle(.kTitleText)
            
            TextField(placeholder, text: $selection)
                .frame(maxWidth: .infinity)
                .padding(16)
                .fontWeight(.medium)
                .foregroundStyle(.kTitleText)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .strokeBorder(Color.kAccent, lineWidth: 2)
                )
                .onChange(of: selection) { oldValue, newValue in
                    if selection.count > charTextLimit{
                        selection = String(newValue.prefix(charTextLimit))
                    }
                }
            
        }
    }
}




#Preview {
    AppTextField(selection: .constant("Test"), label: "Label")
}
