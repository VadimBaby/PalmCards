//
//  NotificationManager.swift
//  PalmCards
//
//  Created by Вадим Мартыненко on 08.08.2023.
//

import Foundation
import UserNotifications

class NotificationManager {
    static let instance = NotificationManager()
    
    func requestAuthorization() {
        let options: UNAuthorizationOptions = [.alert, .badge, .sound]
        
        UNUserNotificationCenter.current().requestAuthorization(options: options) { success, error in
            if let error = error {
                print("Error: \(error)")
            } else {
                print("Success")
            }
        }
    }
    
    func scheduleNotification(nameDictionary: String, inHours: Int) {
        let content = UNMutableNotificationContent()
        content.title = "Вам пора повторить слова из \(nameDictionary)"
        content.sound = .default
        
        let dateNow = Date()
        
        guard let dateNowInSecond = Calendar.current.date(byAdding: .hour, value: inHours, to: dateNow) else { return }
        
        let dateNowIsSecondComponent = Calendar.current.dateComponents([.year, .month, .day], from: dateNowInSecond)
        
        let calendarTrigger = UNCalendarNotificationTrigger(dateMatching: dateNowIsSecondComponent, repeats: false)
        
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: calendarTrigger)
        
        UNUserNotificationCenter.current().add(request)
    }
    
    func cancelNotification() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
    }
}
