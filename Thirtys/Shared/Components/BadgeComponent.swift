//
//  BadgePopUp.swift
//  Thirtys
//
//  Created by Niko Febrianur on 20/05/24.
//

import SwiftUI

struct BadgeComponent: View {
    
    var image: String
    var title: String
    var desc: String
    
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
            
            Image(image)
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
            VStack(spacing: 8) {
                Text(title)
                    .font(.title3)
                    .bold()
                Text(desc)
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
            }
        }
        .padding(.vertical, 25)
        .padding(.horizontal, 50)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(BlurView())
        .cornerRadius(15)
    }
}
struct BlurView : UIViewRepresentable {
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
    
    func makeUIView(context: Context) -> some UIView {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterialLight))
        return view
    }
}

#Preview {
    BadgeComponent(image: "1st-learning", title: "Congratulations! 🎉", desc: "You’ve completed your first learning session! You're off to a great start!", showAchievementPopup: .constant(true))
}
