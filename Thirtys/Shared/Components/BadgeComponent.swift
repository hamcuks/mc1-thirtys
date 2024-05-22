//
//  BadgePopUp.swift
//  Thirtys
//
//  Created by Niko Febrianur on 20/05/24.
//

import SwiftUI

struct BadgeComponent: View {
    @Binding var isPopUpOpen: Bool
    
    var data: BadgeData
    
    var body: some View {
        VStack(spacing: 32) {
            Button(action: {
                isPopUpOpen.toggle()
            }, label: {
                Image(systemName: "xmark.circle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 32, height: 32)
            })
            .foregroundStyle(.gray)
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .trailing)
            
            Text("You Got New Badge!")
                .font(.title2)
                .bold()
            
            Image(data.image)
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
            VStack(spacing: 8) {
                Text(data.greeting)
                    .font(.title3)
                    .bold()
                Text(data.description)
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
            }
        }
        .padding(.vertical, 25)
        .padding(.horizontal, 50)
        .background()
        .cornerRadius(15)
    }
}

#Preview {
    BadgeComponent(isPopUpOpen: .constant(true), data:(BadgeData.items[5]))
}
