//
//  ContentView.swift
//  Thirtys
//
//  Created by Ivan Nur Ilham Syah on 18/05/24.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    let notification = NotificationHandler()

    @AppStorage("firstInstall") private var isFirstInstall = false
    var body: some View {
        if isFirstInstall {
            GetStartedScreen()
                .onAppear{
                    notification.askPermission()
                }
        } else {
            TabViewComponent()
        }
    }
    
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        .environmentObject(OnboardingViewModel())
        .environmentObject(GoalViewModel())
        .environmentObject(TodayViewModel())

}
