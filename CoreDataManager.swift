//
//  CoreDataManager.swift
//  PalmCards
//
//  Created by Вадим Мартыненко on 06.07.2023.
//

import Foundation
import CoreData

class CoreDataManager {
    static let instance = CoreDataManager()
    let container: NSPersistentContainer
    let context: NSManagedObjectContext
    
    init(){
        container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Error: \(error)")
            }
        }
        context = container.viewContext
    }
    
    func save() {
        do{
            try context.save()
            print("Save Successfully")
        } catch let error {
            print("Error save: \(error)")
        }
    }
}
