//
//  RoundedButton.swift
//  Thirtys
//
//  Created by Ivan Nur Ilham Syah on 18/05/24.
//

import SwiftUI

struct AppButtonStyle: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.subheadline)
            .bold()
            .padding(.vertical, 12)
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
            .background(.kAccent)
            .foregroundStyle(.kTitleText)
            .clipShape(Capsule())
    }
    
}

struct BackButton: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        Button(action: { dismiss() }) {
            Image(systemName: "chevron.backward")
                .foregroundStyle(.kTitleText)
                .bold()
                .frame(width: 32, height: 32, alignment: .center)
                .background(.kAccent)
                .clipShape(RoundedRectangle(cornerRadius: 8))
        }
    }
}

#Preview {
    BackButton()
}
