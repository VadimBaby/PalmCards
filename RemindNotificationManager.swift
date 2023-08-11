//
//  RemindNotificationManager.swift
//  PalmCards
//
//  Created by Вадим Мартыненко on 11.08.2023.
//

import Foundation
import CoreData

class RemindNotificationManager: ObservableObject {
    
    let notificationManager = NotificationManager.instance
    
    let coreDataManager = CoreDataManager.instance
    
    var saveEntities: [NotificationEntity] = []
    
    init() {
        getEntities()
    }
    
    func getEntities() {
        let request = NSFetchRequest<NotificationEntity>(entityName: "NotificationEntity")
        
        do{
            saveEntities = try coreDataManager.context.fetch(request)
            
        } catch let error {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    func saveContext() {
        coreDataManager.save()
        getEntities()
    }
}
