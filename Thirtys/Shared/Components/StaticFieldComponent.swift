//
//  StaticFieldComponent.swift
//  Thirtys
//
//  Created by Bayu Septyan Nur Hidayat on 20/05/24.
//

import SwiftUI

struct StaticFieldComponent: View {
    var ContentField: String
    
    var label: String
    var placeholder: String = "Input value"
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8){
            Text("\(label)")
                .font(.subheadline)
                .bold()
                .foregroundStyle(.kTitleText)
            
            Text("\(ContentField)")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(16)
                .font(.system(.subheadline, weight: .semibold))
                .foregroundStyle(.kTitleText)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .strokeBorder(Color.kAccent, lineWidth: 1.5)
                )
        }
    }
}

#Preview {
    StaticFieldComponent( ContentField: "Ini konten", label: "Ini label")
}
