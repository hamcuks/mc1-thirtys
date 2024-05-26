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
    
    @State var isSplashActive: Bool = true
    @AppStorage("firstInstall") private var isFirstInstall = true
    var body: some View {
        if isSplashActive {
            SplashScreen()
                .onAppear {
                    print("First Install: \(isFirstInstall)")
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        withAnimation(.easeOut) {
                            isSplashActive.toggle()
                        }
                    }
                }
        } else {
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
    
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

#Preview {
    ContentView()
        .environmentObject(OnboardingViewModel())
        .environmentObject(GoalViewModel())
        .environmentObject(TodayViewModel())
        .environmentObject(SettingViewModel())

}
