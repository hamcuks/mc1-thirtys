//
//  ThirtysApp.swift
//  Thirtys
//
//  Created by Ivan Nur Ilham Syah on 18/05/24.
//

import SwiftUI

@main
struct ThirtysApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(.light)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(OnboardingViewModel())
                .environmentObject(GoalViewModel())
                .environmentObject(TodayViewModel())
                .environmentObject(DailyStreakViewModel())
                .environmentObject(SettingViewModel())
                .environmentObject(PathHandler())
        }
        
    }
}
