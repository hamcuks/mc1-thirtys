//
//  SplashScreen.swift
//  Thirtys
//
//  Created by Ivan Nur Ilham Syah on 24/05/24.
//

import Foundation
import SwiftUI

struct SplashScreen: View {
    var body: some View {
        ZStack{
            Image(systemName: "book.fill")
                .resizable()
                .scaledToFill()
                .rotationEffect(.degrees(21))
                .foregroundStyle(.kTitleText.opacity(0.1))
            VStack {
                Image(systemName: "book.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(maxHeight: 32)
                    .foregroundStyle(.white)
                
                Text("Thirty's")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
            }
        }
        .foregroundStyle(.white)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.kSuccess)
    }
}

#Preview {
    SplashScreen()
}
