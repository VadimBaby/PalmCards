//
//  RemindNotificationManager.swift
//  PalmCards
//
//  Created by Вадим Мартыненко on 11.08.2023.
//

import Foundation
import CoreData

class RemindNotificationManager: ObservableObject {
    @Published var dictionaryViewModel = DictionaryViewModel()
    
    let notificationManager = NotificationManager.instance
    
    let coreDataManager = CoreDataManager.instance
    
    var saveEntities: [NotificationEntity] = []
    
    init() {
        getEntities()
    }
    
    func sendNotification(selectDictionaries: [String]) {
        selectDictionaries.forEach { idDictionary in
            
            let nameDictionary = dictionaryViewModel.getDictionary(id: idDictionary).name
            
            guard let notificationItem = saveEntities.first(where: {$0.dictionaryID == idDictionary}) else {
                createNewDictionary(idDictionary: idDictionary, nameDictionary: nameDictionary)
                
                return;
            }

            let repeatTime = Date()
            
            guard let lastLearnAfterNotification = notificationItem.lastLearnAfterNotification else { return }
            
            let dateDiffInHours = repeatTime.timeIntervalSince(lastLearnAfterNotification) / 60 / 60
            
            let dateDiffInHoursInt = Int(dateDiffInHours)
            
            let intervalForNextNotificationInHoursInt = Int(notificationItem.intervalForNextNotificationInHours)
            
            if dateDiffInHoursInt > intervalForNextNotificationInHoursInt {
                
                let newInterval = getNextRemindNotificationInHours(lastRemindInHours: intervalForNextNotificationInHoursInt)
                
                notificationManager.scheduleNotification(nameDictionary: nameDictionary, inHours: newInterval)
                
                notificationItem.lastLearn = repeatTime
                notificationItem.lastLearnAfterNotification = repeatTime
                notificationItem.intervalForNextNotificationInHours = Int16(newInterval)
                
            } else {
                notificationItem.lastLearn = repeatTime
            }
            
            saveContext()
        }
    }
    
    func createNewDictionary(idDictionary: String, nameDictionary: String) {
        let newNotificationEntity = NotificationEntity(context: coreDataManager.container.viewContext)
        
        let nowDate = Date()
        
        let nextInterval = getNextRemindNotificationInHours()
        
        newNotificationEntity.dictionaryID = idDictionary
        newNotificationEntity.dictionaryName = nameDictionary
        newNotificationEntity.lastLearn = nowDate
        newNotificationEntity.lastLearnAfterNotification = nowDate
        newNotificationEntity.intervalForNextNotificationInHours = Int16(nextInterval)
        
        saveContext()
        
        notificationManager.scheduleNotification(nameDictionary: nameDictionary, inHours: nextInterval)
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
    
    func getNextRemindNotificationInHours(lastRemindInHours: Int = 0) -> Int {
        
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
