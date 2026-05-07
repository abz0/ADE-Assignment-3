//
//  NotificationManager.swift
//  Assignment_3
//
//  Created by 谭建烨 on 7/5/2026.
//

import Foundation
import UserNotifications

class NotificationManager {
    static let shared = NotificationManager()
    
    func requestPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                print("Notification permission granted")
            } else {
                print("Notification permission denied")
            }
        }
    }
    
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
    
    func sendQuizFinishedNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Great job!"
        content.body = "You finished a quiz today. Keep your streak going!"
        content.sound = .default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let request = UNNotificationRequest(identifier: "quizFinishedReminder", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
    }
}
