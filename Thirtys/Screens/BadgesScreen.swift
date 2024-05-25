//
//  BadgesScreen.swift
//  Thirtys
//
//  Created by Bayu Septyan Nur Hidayat on 21/05/24.
//

import SwiftUI

struct BadgesScreen: View {
    
    var collectedBadges: [BadgeData]
    
    private let columns = Array(repeating: GridItem(.flexible()), count: 4)
    
    
    var body: some View {
        NavigationStack{
            ScrollView{
                LazyVGrid(columns: columns, spacing: 24){
                    ForEach(BadgeData.items, id: \.id){ badge in
                        VStack {
                            Image("\(badge.image)")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 80)
                                .opacity(
                                    collectedBadges.contains(where: { $0.id == badge.id }) ? 1 : 0.5
                                )
                                .grayscale(
                                    collectedBadges.contains(where: { $0.id == badge.id }) ? 0 : 1
                                )
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Badges")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    BadgesScreen(collectedBadges: [])
}
