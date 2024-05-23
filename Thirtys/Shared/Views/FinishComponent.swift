//
//  FinishComponent.swift
//  Thirtys
//
//  Created by Bayu Septyan Nur Hidayat on 22/05/24.
//

import SwiftUI

struct FinishComponent: View {
    var body: some View {
        VStack(spacing: 32){
            Image("finish-learning")
                .resizable()
                .scaledToFit()
                .frame(alignment: .center)
            
            Text("Hooray! You’ve completed your 30 minutes of learning today!")
                .multilineTextAlignment(.center)
                .frame(width: 300,alignment: .center)
                .font(.system(.body, weight: .semibold))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
        .background(.white)
    }
}

#Preview {
    FinishComponent()
}
