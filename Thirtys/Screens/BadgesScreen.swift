//
//  BadgesScreen.swift
//  Thirtys
//
//  Created by Bayu Septyan Nur Hidayat on 21/05/24.
//

import SwiftUI

struct BadgesScreen: View {
    
    private var columns = Array(repeating: GridItem(.flexible()), count: 4)
    private var badgeImage : [BadgeData] = BadgeData.items
    
    @EnvironmentObject private var vm: DailyStreakViewModel
    
    var body: some View {
        NavigationStack{
            ScrollView{
                LazyVGrid(columns: columns){
                    ForEach(badgeImage, id: \.id){ badge in
                        Image("\(badge.image)")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 80)
                            .opacity(vm.isAchieved(badge: badge) ? 1 : 0.5)
                            .grayscale(vm.isAchieved(badge: badge) ? 0 : 1)
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
        .environmentObject(DailyStreakViewModel())
}
