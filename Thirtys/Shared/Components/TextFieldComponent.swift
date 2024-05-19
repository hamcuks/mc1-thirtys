//
//  TextFieldComponent.swift
//  Thirtys
//
//  Created by Bayu Septyan Nur Hidayat on 19/05/24.
//

import SwiftUI

struct ComponenTextField: View {

    @State private var firstShow : Bool = false
    
    @State private var fieldText : String = ""
    var titleColumn : String = "Hanya Coba"
    var errorDesc : String = "Ini adalah error"
    var uiColor = UIColor(red: 0.52, green: 0.86, blue: 0.78, alpha: 1.00)
    let charTextLimit: Int = 40
    
    var body: some View {
        VStack(alignment: .leading){
            Text("\(titleColumn)")
                .bold()
            TextField("", text: $fieldText)
            .placeholder(when: fieldText.isEmpty, placeholder: {
                Text("e.g Belajar SwiftUI")
                    .foregroundColor(.gray)
            })
            .frame(maxWidth: .infinity, maxHeight: 50)
            .padding([.horizontal], 20)
            .tint(.black)
            .overlay(
                RoundedRectangle(cornerRadius: 10).stroke(Color(uiColor: uiColor))
            )
            .onChange(of: fieldText) { oldValue, newValue in
                fieldText = newValue
                if newValue.count > charTextLimit{
                    fieldText = String(newValue.prefix(charTextLimit))
                } else if newValue.isEmpty{
                    
                }
                
            }
            .onSubmit {
                if fieldText.isEmpty{
                    print("next button disabled")
                    firstShow.toggle()
//                    print(firstShow)
                }
            }
            
            if fieldText.isEmpty && !firstShow{
                Text("\(errorDesc)")
                    .frame(maxWidth: .infinity,alignment: .leading)
                    .font(.footnote)
                    .padding(.horizontal, 5)
                    .foregroundColor(.red)
                    .bold()
            }
            
            
        }
        .padding()
        .font(.subheadline)
        
        
    }
}

#Preview(body: {
    ComponenTextField()
})
