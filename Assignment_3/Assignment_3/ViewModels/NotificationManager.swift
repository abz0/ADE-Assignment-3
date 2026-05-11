//
//  NotificationManager.swift
//  Assignment_3
//
//  Created by 谭建烨 on 7/5/2026.
//

import Foundation
import UserNotifications

// handles local notification features used in the app
// UserNotifications is used here to schedule a daily reminder on the device
class NotificationManager {
    static let shared = NotificationManager()
    
    // ask the user for permission before sending notifications
    func requestPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                print("Notification permission granted")
            } else {
                print("Notification permission denied")
            }
        }
    }
    
    // schedule one local notification every day at a fixed time
    func scheduleDailyReminder() {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["dailyStudyReminder"])
        
        let content = UNMutableNotificationContent()
        content.title = "Study Reminder"
        content.body = "Time to study your flashcards today!"
        content.sound = .default
        
        var dateComponents = DateComponents()
        dateComponents.hour = 19
        dateComponents.minute = 0
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let request = UNNotificationRequest(identifier: "dailyStudyReminder", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
    }
}
