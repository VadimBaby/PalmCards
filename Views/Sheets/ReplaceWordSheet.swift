//
//  ReplaceWordSheet.swift
//  PalmCards
//
//  Created by Вадим Мартыненко on 11.07.2023.
//

import SwiftUI

struct ReplaceWordSheet: View {
    @Binding var showReplaceWordSheet: Bool
    var idDictionary: String
    var idWord: String
    var dismiss: () -> ()
    
    @EnvironmentObject var dictionaryViewModel: DictionaryViewModel
    
    @State var selectDictionary: String = ""
    
    var body: some View {
        VStack{
            HStack{
                Spacer()
                Button(action: {
                    showReplaceWordSheet = false
                }) {
                    Image(systemName: "xmark")
                        .tint(Color.primary)
                        .font(.title)
                }
            }
            .padding()
            HStack {
                Text("Словарь:")
                Spacer()
                Picker("Take Dictionary",
                       selection: $selectDictionary) {
                    ForEach(dictionaryViewModel.listDictionaries.filter{$0.id != idDictionary}) { item in
                        Text(item.name)
                            .tag(item.id)
                    }
                }
                .tint(Color.red)
            }
            .padding()
            Spacer()
            Button(action: {
                dictionaryViewModel.replaceWordToAnotherDictionary(idThisDictionary: idDictionary, idToDictionary: selectDictionary, idWord: idWord)
                showReplaceWordSheet = false
                dismiss()
            }) {
                Text("Переместить")
                    .foregroundColor(Color.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 55)
                    .background(Color.blue)
                    .cornerRadius(15)
            }
            .padding()
        }
        .onAppear{
            let filteredDictionaries = dictionaryViewModel.listDictionaries.filter{$0.id != idDictionary}
            selectDictionary = filteredDictionaries[0].id
        }
    }
}

struct ReplaceWordSheet_Previews: PreviewProvider {
    static var empty: () -> Void = {}
    
    static var previews: some View {
        ReplaceWordSheet(showReplaceWordSheet: .constant(true), idDictionary: "1", idWord: "1", dismiss: empty)
            .environmentObject(DictionaryViewModel())
    }
}

