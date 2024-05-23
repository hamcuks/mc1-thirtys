//
//  TabViewComponent.swift
//  Thirtys
//
//  Created by Ivan Nur Ilham Syah on 23/05/24.
//

import SwiftUI

struct TabViewComponent: View {
    var body: some View {
        TabView {
            TodayScreen()
                .tabItem {
                    Label(
                        "Today", systemImage: "smallcircle.fill.circle"
                    )
                }
            
            StreakScreen()
                .tabItem {
                    Label(
                        "Streak", systemImage: "flame"
                    )
                }
            
            GoalsScreen()
                .tabItem {
                    Label(
                        "Goal", systemImage: "target"
                    )
                }
        }
        .tint(.kSuccess)
        
    }
}

#Preview {
    TabViewComponent()
        .environmentObject(TodayViewModel())
        .environmentObject(GoalViewModel())
}
