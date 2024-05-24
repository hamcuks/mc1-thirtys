//
//  NotificationHandler.swift
//  Thirtys
//
//  Created by Bayu Septyan Nur Hidayat on 23/05/24.
//

import Foundation
import UserNotifications

class NotificationHandler {
    
    func askPermission(){
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.badge,.sound]) { success, error in
            if success {
                print("access granted")
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    func sendNotification(date: Date, title: String, body: String){
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = UNNotificationSound.default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: date.timeIntervalSinceNow, repeats: false)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
    }
    
    func scheduleLearningNotifications(suggestionTimes: [Event]) {
        let now = Date()
        
        for suggestionTime in suggestionTimes {
            // Calculate notification time 1 hour before the start of suggested learning time
            let notificationTimeBeforeStart = Calendar.current.date(byAdding: .hour, value: -1, to: suggestionTime.startTime)!
            
            // Schedule notification 1 hour before suggested learning time
            if notificationTimeBeforeStart > now {
                sendNotification(date: notificationTimeBeforeStart, title: "Ignite Your Learning Journey!", body: "Prepare to dive into a world of knowledge and growth. Your learning adventure awaits!")
            }
            
            // Schedule notification at the start of suggested learning time
            if suggestionTime.startTime > now {
                sendNotification(date: suggestionTime.startTime, title: "Empower Your Mind!", body: "It's time to embark on a journey of discovery. Let's make every moment count!")
            }
            
            // Calculate notification time 1 hour before the end of suggested learning time
            let notificationTimeBeforeEnd = Calendar.current.date(byAdding: .hour, value: -1, to: suggestionTime.endTime)!
            
            // Schedule notification 1 hour before the end of suggested learning time
            if notificationTimeBeforeEnd > now {
                sendNotification(date: notificationTimeBeforeEnd, title: "Finish Strong!", body: "As your study session draws to a close, keep pushing forward. Success is just around the corner!")
            }
        }
    }
}

