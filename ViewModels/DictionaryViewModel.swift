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
        
        do{
            let entities: [DictionaryEntity] = try manager.context.fetch(request)
            
            listDictionaries = entities.sorted(by: {$0.createDate ?? Date() > $1.createDate ?? Date()}).compactMap { (entity) -> DictionaryModel? in
                guard let id = entity.id else { return nil }
                guard let name = entity.name else { return nil }
                guard let entityWords = entity.words else { return nil }
                guard let words = try? JSONDecoder().decode([WordModel].self, from: entityWords) else { return nil }
                
               return DictionaryModel(id: id, name: name, words: words)
            }
            
            saveEntities = entities.sorted(by: {$0.createDate ?? Date() > $1.createDate ?? Date()})
            
        } catch let error {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    func deleteDictionary(indexSet: IndexSet) {
        guard let index = indexSet.first else { return }
        let entity = saveEntities[index]
        manager.container.viewContext.delete(entity)
        
        saveContext()
    }
    
    func addDictionary(name: String) {
        let newDictionary = DictionaryEntity(context: manager.container.viewContext)
        
        let words: [WordModel] = []
        
        guard let encodingData = try? JSONEncoder().encode(words) else { return }
        
        newDictionary.name = name
        newDictionary.id = UUID().uuidString
        newDictionary.words = encodingData
        newDictionary.createDate = Date()
        
        saveContext()
    }
    
    func renameDictionary(newName: String, id: String){
        guard let dictionary = saveEntities.first(where: {$0.id == id}) else { return }
        
        dictionary.name = newName
        
        saveContext()
    }
    
    func getDictionary(id: String) -> DictionaryModel {
        return listDictionaries.first { item in
            return item.id == id
        } ?? DictionaryModel(id: "error", name: "Error", words: [])
    }
    
    func addWords(name: String, translate: String, transcription: String, examples: String, translateExamples: String, id: String) {
        
        guard let entity = saveEntities.first(where: {$0.id == id}) else { return }
        guard let encodeWords = entity.words else { return }
        guard var words = try? JSONDecoder().decode([WordModel].self, from: encodeWords) else { return }
        
        words.append(WordModel(
            name: name,
            translate: translate,
            examples: examples,
            translateExamples: translateExamples,
            transcription: transcription
        ))
        
        guard let decodeWords = try? JSONEncoder().encode(words) else { return }
        
        entity.words = decodeWords
        
        saveContext()
    }
    
    func deleteWord(indexSet: IndexSet, id: String) {
        guard let dictionary = saveEntities.first(where: {$0.id == id}) else { return }
        guard let encodeWords = dictionary.words else { return }
        guard var words = try? JSONDecoder().decode([WordModel].self, from: encodeWords) else { return }
        
        words.remove(atOffsets: indexSet)
        
        guard let decodeWords = try? JSONEncoder().encode(words) else { return }
        
        dictionary.words = decodeWords
        
        saveContext()
    }
    
    func renameWord(newName: String, newTranslate: String, newTrancription: String, newExamples: String, newTranslateExamples: String, idDictionary: String, idWord: String) {
        
        guard let dictionary = saveEntities.first(where: {$0.id == idDictionary}) else { return }
        guard let encodeWords = dictionary.words else { return }
        guard var words = try? JSONDecoder().decode([WordModel].self, from: encodeWords) else { return }
        
        guard let indexWord = words.firstIndex(where: {$0.id == idWord}) else { return }
        
        words[indexWord].name = newName
        words[indexWord].translate = newTranslate
        words[indexWord].transcription = newTrancription
        words[indexWord].examples = newExamples
        words[indexWord].translateExamples = newTranslateExamples
        
        guard let decodeWords = try? JSONEncoder().encode(words) else { return }
        
        dictionary.words = decodeWords
        
        saveContext()
    }
    
    func replaceWordToAnotherDictionary(idThisDictionary: String, idToDictionary: String, idWord: String) {
        
        guard let dictionary = saveEntities.first(where: {$0.id == idThisDictionary}) else { return }
        guard let encodeWords = dictionary.words else { return }
        guard var words = try? JSONDecoder().decode([WordModel].self, from: encodeWords) else { return }
        
        guard let word = words.first(where: {$0.id == idWord}) else { return }
        
        words = words.filter{$0.id != word.id}
        
        guard let decodeWords = try? JSONEncoder().encode(words) else { return }
        
        dictionary.words = decodeWords
        
        guard let toDictionary = saveEntities.first(where: {$0.id == idToDictionary}) else { return }
        guard let toEncodeWords = toDictionary.words else { return }
        guard var toWords = try? JSONDecoder().decode([WordModel].self, from: toEncodeWords) else { return }
        
        toWords.append(word)
        
        guard let toDecodeWords = try? JSONEncoder().encode(toWords) else { return }
        
        toDictionary.words = toDecodeWords
        
        saveContext()
    }
    
    func saveContext() {
        manager.save()
        getEntities()
    }
}
