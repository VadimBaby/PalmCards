//
//  DictionaryView.swift
//  PalmCards
//
//  Created by Вадим Мартыненко on 06.07.2023.
//

import SwiftUI

struct DictionaryView: View {
    @EnvironmentObject var dictionaryViewModel: DictionaryViewModel
    
    @State var showSheet: Bool = false
    @State var search: String = ""
    
    @State private var editMode: EditMode = .inactive
    
    var body: some View {
        NavigationStack {
            ZStack{
                if dictionaryViewModel.listDictionaries.isEmpty {
                    NoItemDictionaryView()
                } else {
                    List {
                        ForEach(filteredDictionaries){ item in
                            NavigationLink(destination: ListWordsView(id: item.id)) {
                                Text(item.name)
                            }
                        }
                        .onDelete(perform: dictionaryViewModel.deleteDictionary)
                        
                        if filteredDictionaries.isEmpty {
                            Spacer()
                                .listRowBackground(Color.clear)
                        }
                    }
                    .animation(.easeInOut, value: editMode)
                    .environment(\.editMode, $editMode)
                }
            }
            .sheet(isPresented: $showSheet, content: {AddDictionarySheet(showSheet: $showSheet)})
            .searchable(text: $search, prompt: "Искать")
            .navigationTitle("Словари")
            .toolbar {
                if(!dictionaryViewModel.listDictionaries.isEmpty) {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        EditButtonComponent(editMode: $editMode)
                    }
                }
            
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        self.showSheet = true
                    }) {
                        Image(systemName: "plus")
                            .foregroundColor(Color.red)
                    }
                }
            }
        }
    }
    
    var filteredDictionaries: [DictionaryModel] {
        if search.isEmpty {
            return dictionaryViewModel.listDictionaries
        } else {
            return dictionaryViewModel.listDictionaries.filter {$0.name.lowercased().contains(search.lowercased())}
        }
    }
}

struct DictionaryView_Previews: PreviewProvider {
    static var previews: some View {
        DictionaryView()
            .environmentObject(DictionaryViewModel())
    }
}
