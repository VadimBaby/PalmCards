//
//  DictionaryView.swift
//  PalmCards
//
//  Created by Вадим Мартыненко on 06.07.2023.
//

import SwiftUI

struct DictionaryView: View {
    @EnvironmentObject var dictionaryViewModel: DictionaryViewModel
    
    var body: some View {
        NavigationStack {
            ZStack{
                if dictionaryViewModel.listDictionaries.isEmpty {
                    NoItemDictionaryView()
                } else {
                    List {
                        ForEach(dictionaryViewModel.listDictionaries){ item in
                            Text(item.name)
                        }
                        .onDelete(perform: dictionaryViewModel.deleteDictionary)
                    }
                }
            }
            .navigationTitle("Словари")
            .toolbar {
                if(!dictionaryViewModel.listDictionaries.isEmpty) {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        EditButton()
                            .tint(Color.red)
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {}) {
                        Image(systemName: "plus")
                            .foregroundColor(Color.red)
                    }
                }
            }
        }
    }
}

struct DictionaryView_Previews: PreviewProvider {
    static var previews: some View {
        DictionaryView()
            .environmentObject(DictionaryViewModel())
    }
}
