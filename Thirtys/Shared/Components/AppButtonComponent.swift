//
//  RoundedButton.swift
//  Thirtys
//
//  Created by Ivan Nur Ilham Syah on 18/05/24.
//

import SwiftUI

struct AppButton: View {
    var label: String
    var body: some View {
        Text(label)
            .font(.subheadline)
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
            .bold()
            .padding(.vertical, 12)
            .background(.kAccent)
            .clipShape(RoundedRectangle(cornerRadius: 56))
    }
}

#Preview {
    AppButton(label: "Button")
}
