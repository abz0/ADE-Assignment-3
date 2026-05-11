//
//  StreakManager.swift
//  Assignment_3
//
//  Created by 谭建烨 on 7/5/2026.
//

import Foundation

// stores and updates the user's study streak using UserDefaults
// UserDefaults is used here because the app only needs simple local storage
class StreakManager {
    static let shared = StreakManager()
    
    let streakKey = "StudyStreak"
    let lastStudyDateKey = "LastStudyDate"
    
    // update the streak when the user finishes a study session
    func recordStudySession() {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        
        if let savedDate = UserDefaults.standard.object(forKey: lastStudyDateKey) as? Date {
            let lastDate = calendar.startOfDay(for: savedDate)
            
            if calendar.isDate(lastDate, inSameDayAs: today) {
                return
            }
            
            if let difference = calendar.dateComponents([.day], from: lastDate, to: today).day {
                if difference == 1 {
                    let currentStreak = UserDefaults.standard.integer(forKey: streakKey)
                    UserDefaults.standard.set(currentStreak + 1, forKey: streakKey)
                } else {
                    UserDefaults.standard.set(1, forKey: streakKey)
                }
            }
        } else {
            UserDefaults.standard.set(1, forKey: streakKey)
        }
        
        UserDefaults.standard.set(today, forKey: lastStudyDateKey)
    }
    
    // return the current saved streak value
    func getCurrentStreak() -> Int {
        return UserDefaults.standard.integer(forKey: streakKey)
    }
}
