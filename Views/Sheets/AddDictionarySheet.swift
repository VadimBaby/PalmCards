//
//  AddDictionarySheet.swift
//  PalmCards
//
//  Created by Вадим Мартыненко on 08.07.2023.
//

import SwiftUI

struct AddDictionarySheet: View {
    @Binding var showSheet: Bool
    @EnvironmentObject var dictionaryViewModel: DictionaryViewModel
    @State var nameDictionary: String = ""
    @FocusState var focusNameDictionary: Bool
    
    var body: some View {
        ZStack{
            VStack{
                HStack{
                    Spacer()
                    Button(action: {
                        showSheet = false
                    }, label: {
                        Image(systemName: "xmark")
                            .tint(Color.primary)
                            .font(.title)
                    })
                }
                .padding()
                Spacer()
                TextField("Название словаря", text: $nameDictionary)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .frame(height: 55)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(15)
                    .padding(.horizontal)
                    .focused($focusNameDictionary)
                    .onTapGesture {
                        focusNameDictionary = true
                    }
                Button(action: {
                    dictionaryViewModel.addDictionary(name: nameDictionary.trimmingCharacters(in: .whitespacesAndNewlines))
                    nameDictionary = ""
                    showSheet = false
                }, label: {
                    Text("Добавить")
                        .frame(maxWidth: .infinity)
                        .frame(height: 55)
                        .background(nameDictionary.trimmingCharacters(in: .whitespacesAndNewlines) == "" ? Color.gray.opacity(0.2) : Color.blue)
                        .cornerRadius(15)
                        .tint(Color.white)
                })
                .padding()
                .disabled(nameDictionary.trimmingCharacters(in: .whitespacesAndNewlines) == "" ? true : false)
                Spacer()
            }
        }
    }
}

struct AddDictionarySheet_Previews: PreviewProvider {
    static var previews: some View {
        AddDictionarySheet(showSheet: .constant(false))
            .environmentObject(DictionaryViewModel())
    }
}
