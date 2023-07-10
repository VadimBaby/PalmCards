//
//  RenameDictionarySheet.swift
//  PalmCards
//
//  Created by Вадим Мартыненко on 10.07.2023.
//

import SwiftUI

struct RenameDictionarySheet: View {
    @Binding var showSheet: Bool
    
    var id: String
    let oldNameDictionary: String
    
    @EnvironmentObject var dictionaryViewModel: DictionaryViewModel
    @FocusState var focusNameDictionary: Bool
    
    @State var nameDictionary: String = ""
    
    @State var isRightNameToRename: Bool = false
    
    var body: some View {
        ZStack{
            VStack{
                xmarkComponent
                
                Spacer()
                
                TextField("Новое название словаря", text: $nameDictionary)
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
                    .onChange(of: nameDictionary) { newValue in
                        isRightNameToRename = nameDictionary.trimmingCharacters(in: .whitespacesAndNewlines) == "" || nameDictionary.trimmingCharacters(in: .whitespacesAndNewlines) == oldNameDictionary
                    }
                Button(action: pressOnButton, label: {
                    Text("Изменить")
                        .frame(maxWidth: .infinity)
                        .frame(height: 55)
                        .background(isRightNameToRename ? Color.gray.opacity(0.2) : Color.blue)
                        .cornerRadius(15)
                        .tint(Color.white)
                })
                .padding()
                .disabled(isRightNameToRename ? true : false)
                Spacer()
            }
        }
        .onTapGesture {
            focusNameDictionary = false
        }
        .onAppear{
            nameDictionary = oldNameDictionary
        }
    }
    
    func pressOnButton() {
        dictionaryViewModel.renameDictionary(newName: nameDictionary, id: id)
        nameDictionary = ""
        self.showSheet = false
    }
    
    var xmarkComponent: some View {
        HStack{
            Spacer()
            Button(action: {
                self.showSheet = false
            }, label: {
                Image(systemName: "xmark")
                    .font(.title)
                    .tint(Color.primary)
            })
        }
        .padding()
    }
}

struct RenameDictionarySheet_Previews: PreviewProvider {
    static var previews: some View {
        RenameDictionarySheet(showSheet: .constant(true), id: "1", oldNameDictionary: "Old Name")
    }
}
