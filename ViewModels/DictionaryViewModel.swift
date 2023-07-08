//
//  DictionaryViewModel.swift
//  PalmCards
//
//  Created by Вадим Мартыненко on 06.07.2023.
//

import Foundation
import CoreData

class DictionaryViewModel: ObservableObject {
    let manager = CoreDataManager.instance
    
    @Published var saveEntities: [DictionaryEntity] = []
    
    @Published var listDictionaries: [DictionaryModel] = []
    
    init() {
        getEntities()
    }
    
    func getEntities() {
        let request = NSFetchRequest<DictionaryEntity>(entityName: "DictionaryEntity")
        
        let sort = NSSortDescriptor(keyPath: \DictionaryEntity.createDate, ascending: true)
        request.sortDescriptors = [sort]
        
        do{
            let entities: [DictionaryEntity] = try manager.context.fetch(request)
            
            listDictionaries = entities.sorted(by: {$0.createDate ?? Date() > $1.createDate ?? Date()}).compactMap { (entity) -> DictionaryModel? in
                guard let id = entity.id else { return nil }
                guard let name = entity.name else { return nil }
                guard let entityWords = entity.words else { return nil }
                guard let words = try? JSONDecoder().decode([WordModel].self, from: entityWords) else { return nil }
                
               return DictionaryModel(id: id, name: name, words: words)
            }
            
            saveEntities = entities
            
        } catch let error {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    func deleteDictionary(indexSet: IndexSet) {
        guard let index = indexSet.first else { return }
        let entity = saveEntities[index]
        manager.container.viewContext.delete(entity)
        
        manager.save()
        
        listDictionaries.remove(atOffsets: indexSet)
    }
}
