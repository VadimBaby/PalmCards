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
    
    func scheduleNotification(idDictionary: String, nameDictionary: String, inHours: Int) {
        let content = UNMutableNotificationContent()
        content.title = "PalmCards"
        content.subtitle = "Вам пора повторить слова из \(nameDictionary)"
        content.sound = .default
        
        let dateNow = Date()
        
        guard let dateNowInSecond = Calendar.current.date(byAdding: .hour, value: inHours, to: dateNow) else { return }
        
        let dateNowIsSecondComponent = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: dateNowInSecond)
        
        let calendarTrigger = UNCalendarNotificationTrigger(dateMatching: dateNowIsSecondComponent, repeats: false)
        
        let request = UNNotificationRequest(
            identifier: idDictionary + String(inHours),
            content: content,
            trigger: calendarTrigger)
        
        UNUserNotificationCenter.current().add(request)
    }
    
    func cancelNotification(id: String) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [id])
    }
}
