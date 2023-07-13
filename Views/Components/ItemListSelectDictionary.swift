//
//  ItemListSelectDictionary.swift
//  PalmCards
//
//  Created by Вадим Мартыненко on 13.07.2023.
//

import SwiftUI

struct ItemListSelectDictionary: View {
    @Binding var selectDictionaries: [String]
    
    var name: String
    var id: String
    
    var body: some View {
        HStack{
            Text(name)
            Spacer()
            ZStack{
                Rectangle()
                    .frame(width: 30, height: 30)
                Rectangle()
                    .fill(Color.white)
                    .frame(width: 25, height: 25)
                    Image(systemName: "checkmark")
                        .foregroundColor(Color.green)
                        .font(.title2)
                        .opacity(selectDictionaries.contains(id) ? 1 : 0)
            }
        }
        .onTapGesture {
            if !selectDictionaries.contains(id) {
                selectDictionaries.append(id)
            } else {
                selectDictionaries = selectDictionaries.filter{$0 != id}
            }
            
            guard let encodingData = try? JSONEncoder().encode(selectDictionaries) else { return }
            
            UserDefaults.standard.set(encodingData, forKey: "selectDictionaries")
        }
    }
}

struct ItemListSelectDictionary_Previews: PreviewProvider {
    static var previews: some View {
        ItemListSelectDictionary(selectDictionaries: .constant([]), name: "name", id: "1")
    }
}
