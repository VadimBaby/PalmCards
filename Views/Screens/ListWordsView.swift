//
//  ListWordsView.swift
//  PalmCards
//
//  Created by Вадим Мартыненко on 09.07.2023.
//

import SwiftUI

struct ListWordsView: View {
    var id: String
    @EnvironmentObject var dictionaryViewModel: DictionaryViewModel
    
    @State var showAddSheet: Bool = false
    @State var showRenameSheet: Bool = false
    
    @State var search: String = ""
    @State var chag: Bool = false
    
    @State private var editMode: EditMode = .inactive
    
    var dictionary: DictionaryModel {
        return dictionaryViewModel.getDictionary(id: id)
    }
    
    var body: some View {
        ZStack{
            BackgroundColor()
            
            if dictionary.words.isEmpty {
                NoItemListWordsView()
            } else {
                List {
                    ForEach(filteredWords) { item in
                        NavigationLink(destination: EditWordView(idDictionary: id, word: item)) {
                            HStack{
                                Text(item.name)
                                    .font(.headline)
                                Spacer()
                                Text(item.translate)
                                    .font(.footnote)
                                    .foregroundColor(Color.secondary)
                            }
                        }
                    }
                    .onDelete { IndexSet in
                        dictionaryViewModel.deleteWord(indexSet: IndexSet, id: id)
                    }
                    
                    if filteredWords.isEmpty {
                        Spacer()
                            .listRowBackground(Color.clear)
                    }
                }
                .animation(.easeInOut, value: editMode)
                .environment(\.editMode, $editMode)
                .searchable(text: $search, placement: chag || UIDevice.current.userInterfaceIdiom == .pad ? .toolbar : .navigationBarDrawer(displayMode: .always) ,prompt: "Искать")
                .onAppear{
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.6, execute: {
                        self.chag = true
                    })
                }
            }
        }
        .sheet(isPresented: $showRenameSheet, content: {
            RenameDictionarySheet(showSheet: $showRenameSheet, id: id, oldNameDictionary: dictionary.name)
        })
        .sheet(isPresented: $showAddSheet, content: {
            AddWordSheet(showAddSheet: $showAddSheet, id: id)
        })
        .navigationTitle(dictionary.name)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                HStack{
                    EditButtonComponent(editMode: $editMode)
                    
                    Button(action: {
                        self.showRenameSheet = true
                    }, label: {
                        Image(systemName: "pencil")
                            .tint(Color.red)
                    })
                    
                    Button(action: {
                        self.showAddSheet = true
                    }) {
                        Image(systemName: "plus")
                            .tint(Color.red)
                    }
                }
            }
        }
    }
    
    var filteredWords: [WordModel] {
        if search.isEmpty {
            return dictionary.words
        } else {
            return dictionary.words.filter{$0.name.lowercased().contains(search.lowercased()) || $0.translate.lowercased().contains(search.lowercased())}
        }
    }
}

//struct ListWordsView_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationStack{
//            ListWordsView(id: "1")
//        }
//    }
//}
