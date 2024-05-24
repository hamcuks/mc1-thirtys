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
        Image(systemName: "book.fill")
            .resizable()
            .scaledToFit()
            .frame(maxHeight: 64)
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.kSuccess)
    }
}

#Preview {
    SplashScreen()
}
