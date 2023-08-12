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
    
    func getNextRemindNotificationInHours(lastRemindInHours: Int?) -> Int {
        
        guard let lastRemindInHours = lastRemindInHours else { return 0 }
        
        switch lastRemindInHours {
        
        case 0:
            return 6
            
        case 6:
            return 12
            
        case 12:
            return 18
        
        case 18:
            return 24
            
        case 24:
            return 30
        
        case 30:
            return 38
        
        case 38:
            return 48
        
        case 48:
            return 56
        
        case 56:
            return 72
        
        case 72:
            return 168
        
        case 168:
            return 252
        
        case 252:
            return 336
            
        case 336:
            return 504
        
        case 504:
            return 730
        
        case 730:
            return 1095
            
        case 1095:
            return 1460
        
        case 1460:
            return 2190
            
        case 2190:
            return 3285
            
        case 3285:
            return 4380
            
        case 4380:
            return 5840
            
        case 5840:
            return 8760
            
        case 8760:
            return 13140
            
        case 13140:
            return 17520
            
        default:
            return lastRemindInHours + 8760
        
        }
    }
}
