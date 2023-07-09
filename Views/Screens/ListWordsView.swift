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
    
    var dictionary: DictionaryModel {
        return dictionaryViewModel.getDictionary(id: id)
    }
    
    var body: some View {
        ZStack{
            if dictionary.words.isEmpty {
                VStack{}
            } else {
                List {
                    ForEach(dictionary.words) { item in
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
            }
        }
        .navigationTitle(dictionary.name)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {}, label: {
                    Image(systemName: "pencil")
                        .tint(Color.red)
                })
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {}) {
                    Image(systemName: "plus")
                        .tint(Color.red)
                }
            }
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
