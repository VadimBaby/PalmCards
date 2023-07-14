//
//  PlayView.swift
//  PalmCards
//
//  Created by Вадим Мартыненко on 06.07.2023.
//

import SwiftUI
import Combine

class PlayViewModel: ObservableObject {
    
    @Published var selectDictionaries: [String] = []
    @Published var listWordsFromSelectDictionaries: [WordModel] = []
    @Published var islistWordsFromSelectDictionariesEmpty = true
    @Published var isBothOfListEmpty = true
    
    var cancellables = Set<AnyCancellable>()
    
    init() {
        addIslistWordsFromSelectDictionariesEmpty()
    }
    
    deinit {
        for item in cancellables {
            item.cancel()
        }
    }
    
    func addIslistWordsFromSelectDictionariesEmpty() {
        $listWordsFromSelectDictionaries
            .map { (listWords) -> Bool in
                return listWords.isEmpty
            }
            .sink { [weak self] isEmpty in
                guard let self = self else { return }
                
                self.islistWordsFromSelectDictionariesEmpty = isEmpty
            }
            .store(in: &cancellables)
    }
}

struct PlayView: View {
    @StateObject var playViewModel = PlayViewModel()
    
    @EnvironmentObject var dictionaryViewModel: DictionaryViewModel
    @EnvironmentObject var settings: Settings
    
    @State private var doCardsNavigate: Bool = false
    @State private var doWritingNavigate: Bool = false

    let listOfTypeGames = ["cards", "write words"]
    
    var body: some View {
        NavigationStack{
            ZStack {
                BackgroundColor()
                
                VStack{
                    if dictionaryViewModel.listDictionaries.isEmpty {
                        NoItemDictionaryView()
                    } else {
                        VStack{
                            List {
                                ForEach(dictionaryViewModel.listDictionaries) { dictionary in
                                    ItemListSelectDictionary(
                                        selectDictionaries: $playViewModel.selectDictionaries,
                                        name: dictionary.name,
                                        id: dictionary.id
                                    )
                                }
                            }
                            .frame(height: 400)
                        }
                    }
                    
                    Spacer()
                    
                    Button(action: {}) {
                        Text(playViewModel.islistWordsFromSelectDictionariesEmpty ? "У вас нет слов" : "Играть")
                            .foregroundColor(
                                playViewModel.islistWordsFromSelectDictionariesEmpty ? Color.red : Color.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 55)
                            .background(playViewModel.isBothOfListEmpty ? Color.gray.opacity(0.2) : Color.blue)
                            .cornerRadius(15)
                            .padding()
                    }
                    .disabled(playViewModel.isBothOfListEmpty)
                }
            }
            .navigationTitle("Играть")
            .onReceive(playViewModel.$selectDictionaries) { listOfId in
                
                var listWords: [WordModel] = []
                
                if !listOfId.isEmpty {
                    for id in listOfId {
                        let dictionary = self.dictionaryViewModel.getDictionary(id: id)
                        
                        listWords += dictionary.words
                    }
                }
                
                playViewModel.listWordsFromSelectDictionaries = listWords
            }
            .onReceive(dictionaryViewModel.$listDictionaries) { listDictionaries in
                var listWords: [WordModel] = []
                
                if !playViewModel.selectDictionaries.isEmpty {
                    for id in playViewModel.selectDictionaries {
                        let dictionary = self.dictionaryViewModel.getDictionary(id: id)
                        
                        listWords += dictionary.words
                    }
                }
                
                playViewModel.listWordsFromSelectDictionaries = listWords
                
                playViewModel.isBothOfListEmpty = listDictionaries.isEmpty || playViewModel.islistWordsFromSelectDictionariesEmpty
            }
            .onReceive(playViewModel.$islistWordsFromSelectDictionariesEmpty) { newValue in
                playViewModel.isBothOfListEmpty = newValue || dictionaryViewModel.listDictionaries.isEmpty
            }
            .onAppear{
                guard !dictionaryViewModel.listDictionaries.isEmpty else {
                    playViewModel.selectDictionaries = []
                    
                    guard let encodingData = try? JSONEncoder().encode(playViewModel.selectDictionaries) else { return }
                    
                    UserDefaults.standard.set(encodingData, forKey: "selectDictionaries")
                    
                    return
                }
                
                guard let data = UserDefaults.standard.data(forKey: "selectDictionaries") else { return }
                
                guard let savedItems = try? JSONDecoder().decode([String].self, from: data) else { return }
                
                var listDeletedDictionaries: [String] = []
                
                // в listDeletedDictionaries добавляем id тех словарей, которые содержится в сохраненной в память переменной chosenDictionaries, но не содержится в списке словарей
                
                savedItems.forEach { item in
                    if !dictionaryViewModel.listDictionaries.contains(where: {$0.id == item}) {
                        listDeletedDictionaries.append(item)
                    }
                }
                
                // если переменная пустая, то делаем просто инициализацию, в ином случае из takeSavedItems извлекаем словари, которых не существует и сохраняем измененую переменную

                if listDeletedDictionaries.isEmpty {
                    playViewModel.selectDictionaries = savedItems
                } else {
                    playViewModel.selectDictionaries = savedItems.filter({ item in
                        return !listDeletedDictionaries.contains(item)
                    })
                    
                    guard let encodingData = try? JSONEncoder().encode(playViewModel.selectDictionaries) else { return }
                    
                    UserDefaults.standard.set(encodingData, forKey: "selectDictionaries")
                }
            }
        }
    }
}

struct PlayView_Previews: PreviewProvider {
    static var previews: some View {
        PlayView()
            .environmentObject(DictionaryViewModel())
            .environmentObject(Settings())
    }
}
