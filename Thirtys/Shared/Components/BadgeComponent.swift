//
//  BadgePopUp.swift
//  Thirtys
//
//  Created by Niko Febrianur on 20/05/24.
//

import SwiftUI

struct BadgePopUp: View {
    
    var badge: BadgeData
    @Binding var showAchievementPopup: Bool
    
    var body: some View {
        VStack(spacing: 32) {
            Button(action: {
                showAchievementPopup.toggle()
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
            
            Image(badge.image)
                .resizable()
                .scaledToFit()
                .frame(height: 128)
            VStack(spacing: 8) {
                Text(badge.greeting)
                    .font(.title3)
                    .bold()
                Text(badge.description)
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
            }
        }
        .padding(.vertical, 32)
        .padding(.horizontal, 24)
        .background()
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .padding(.horizontal, 32)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.black.opacity(0.3))
        .ignoresSafeArea()
    }
}

#Preview {
    BadgePopUp(
        badge: BadgeData.items.first!,
        showAchievementPopup: .constant(false)
    )
}
