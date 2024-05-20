//
//  RoundedButton.swift
//  Thirtys
//
//  Created by Ivan Nur Ilham Syah on 18/05/24.
//

import SwiftUI

struct AppButton: View {
    var label: String
    var isDisabled: Bool = false
    
    var body: some View {
        Text(label)
            .font(.subheadline)
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
            .bold()
            .padding(.vertical, 12)
            .background(!isDisabled ? .kAccent : .kSecondary)
            .clipShape(RoundedRectangle(cornerRadius: 56))
    }
}

struct BackButton: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        Button(action: { dismiss() }) {
            Image(systemName: "chevron.backward")
                .foregroundStyle(.kTitleText)
                .bold()
                .frame(width: 40, height: 40, alignment: .center)
                .background(.kAccent)
                .clipShape(RoundedRectangle(cornerRadius: 8))
        }
    }
}

#Preview {
    AppButton(label: "Button")
}
