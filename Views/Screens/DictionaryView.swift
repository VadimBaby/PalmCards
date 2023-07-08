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
            .sheet(isPresented: $showSheet, content: {AddDictionarySheet(showSheet: $showSheet)})
            .navigationTitle("Словари")
            .toolbar {
                if(!dictionaryViewModel.listDictionaries.isEmpty) {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        EditButton()
                            .tint(Color.red)
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
}

struct DictionaryView_Previews: PreviewProvider {
    static var previews: some View {
        DictionaryView()
            .environmentObject(DictionaryViewModel())
    }
}
