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
            //            .placeholder(when: fieldText.isEmpty, placeholder: {
            //                Text("e.g Belajar SwiftUI")
            //                    .foregroundColor(.gray)
            //            })
                .frame(maxWidth: .infinity)
                .padding(16)
            //            .tint(.kTitleText)
                .fontWeight(.medium)
                .foregroundStyle(.kTitleText)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .strokeBorder(Color.kAccent, lineWidth: 1.5)
                )
                .onChange(of: selection) { oldValue, newValue in
                    if selection.count > charTextLimit{
                        selection = String(newValue.prefix(charTextLimit))
                    }
                }
                .onSubmit {
                    //                if fieldText.isEmpty{
                    //                    print("next button disabled")
                    //                    firstShow.toggle()
                    ////                    print(firstShow)
                    //                }
                }
            //
            //            if fieldText.isEmpty && !firstShow{
            //                Text("\(errorDesc)")
            //                    .frame(maxWidth: .infinity,alignment: .leading)
            //                    .font(.footnote)
            //                    .padding(.horizontal, 5)
            //                    .foregroundColor(.red)
            //                    .bold()
            //            }
            
            
        }
    }
}

#Preview {
    AppTextField(selection: .constant("Text"), label: "Label")
}
