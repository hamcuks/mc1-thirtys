//
//  BadgesScreen.swift
//  Thirtys
//
//  Created by Bayu Septyan Nur Hidayat on 21/05/24.
//

import SwiftUI

struct BadgesScreen: View {
    
    var columns = Array(repeating: GridItem(.flexible()), count: 4)
    
    var badgeImage : [BadgeData] = BadgeData.items
    
    var body: some View {
        NavigationStack{
            ScrollView{
                LazyVGrid(columns: columns){
                    ForEach(badgeImage, id: \.id){ badge in
                        Image("\(badge.image)")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 80)
                            .opacity(badge.isAchieved ? 1 : 0.3)
                            .border(.red)
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
    BadgesScreen()
}
