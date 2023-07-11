//
//  EditWordView.swift
//  PalmCards
//
//  Created by Вадим Мартыненко on 11.07.2023.
//

import SwiftUI

struct EditWordView: View {
    let idDictionary: String
    let word: WordModel
    
    @EnvironmentObject var dictionaryViewModel: DictionaryViewModel
    
    @Environment(\.dismiss) var dismiss
    
    enum FocusTextField: Hashable {
        case name
        case translate
        case transcription
        case examples
        case translateExamples
    }
    
    @State var nameTextField: String = ""
    @State var translateTextField: String = ""
    @State var transcriptionTextField: String = ""
    @State var examplesTextField: String = ""
    @State var translateExamplesTextField: String = ""
    
    @State var nameTextFieldClear: String = ""
    @State var translateTextFieldClear: String = ""
    @State var transcriptionTextFieldClear: String = ""
    @State var examplesTextFieldClear: String = ""
    @State var translateExamplesTextFieldClear: String = ""
    
    @State var isWrong: Bool = true
    
    @FocusState private var focusTextField: FocusTextField?
    
    var body: some View {
        ZStack{
            BackgroundColor()
            
            ScrollView {
                VStack{
                    TextField("Слово", text: $nameTextField)
                        .padding(.horizontal)
                        .frame(maxWidth: .infinity)
                        .frame(height: 55)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(15)
                        .padding(.horizontal)
                        .focused($focusTextField, equals: .name)
                        .onTapGesture {
                            focusTextField = .name
                        }
                        .onChange(of: nameTextField) { newValue in
                            nameTextFieldClear = newValue.trimmingCharacters(in: .whitespacesAndNewlines)
                            setIsWrong()
                        }
                    
                    TextField("Перевод", text: $translateTextField)
                        .padding(.horizontal)
                        .frame(maxWidth: .infinity)
                        .frame(height: 55)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(15)
                        .padding(.horizontal)
                        .focused($focusTextField, equals: .translate)
                        .onTapGesture {
                            focusTextField = .translate
                        }
                        .onChange(of: translateTextField) { newValue in
                            translateTextFieldClear = newValue.trimmingCharacters(in: .whitespacesAndNewlines)
                            setIsWrong()
                        }
                    
                    TextField("Транскрипция", text: $transcriptionTextField)
                        .padding(.horizontal)
                        .frame(maxWidth: .infinity)
                        .frame(height: 55)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(15)
                        .padding(.horizontal)
                        .focused($focusTextField, equals: .transcription)
                        .onTapGesture {
                            focusTextField = .transcription
                        }
                        .onChange(of: transcriptionTextField) { newValue in
                            transcriptionTextFieldClear = newValue.trimmingCharacters(in: .whitespacesAndNewlines)
                            setIsWrong()
                        }
                    
                    TextField("Пример", text: $examplesTextField)
                        .padding(.horizontal)
                        .frame(maxWidth: .infinity)
                        .frame(height: 55)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(15)
                        .padding(.horizontal)
                        .focused($focusTextField, equals: .examples)
                        .onTapGesture {
                            focusTextField = .examples
                        }
                        .onChange(of: examplesTextField) { newValue in
                            examplesTextFieldClear = newValue.trimmingCharacters(in: .whitespacesAndNewlines)
                            setIsWrong()
                        }
                    
                    TextField("Перевод примера", text: $translateExamplesTextField)
                        .padding(.horizontal)
                        .frame(maxWidth: .infinity)
                        .frame(height: 55)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(15)
                        .padding(.horizontal)
                        .focused($focusTextField, equals: .translateExamples)
                        .onTapGesture {
                            focusTextField = .translateExamples
                        }
                        .onChange(of: translateExamplesTextField) { newValue in
                            translateExamplesTextFieldClear = newValue.trimmingCharacters(in: .whitespacesAndNewlines)
                            setIsWrong()
                        }
                    
                    Button(action: {
                        dictionaryViewModel.renameWord(
                            newName: nameTextFieldClear,
                            newTranslate: translateTextFieldClear,
                            newTrancription: transcriptionTextFieldClear,
                            newExamples: examplesTextFieldClear,
                            newTranslateExamples: translateExamplesTextFieldClear,
                            idDictionary: idDictionary,
                            idWord: word.id)
                        dismiss()
                    }, label: {
                        Text("Изменить")
                            .frame(maxWidth: .infinity)
                            .frame(height: 55)
                            .background(isWrong ? Color.gray.opacity(0.2) : Color.blue)
                            .cornerRadius(15)
                            .tint(Color.white)
                    })
                    .padding()
                    .disabled(isWrong ? true : false)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .onTapGesture {
                focusTextField = nil
            }
        }
        .onAppear{
            nameTextField = word.name
            translateTextField = word.translate
            transcriptionTextField = word.transcription
            examplesTextField = word.examples
            translateExamplesTextField = word.translateExamples
        }
    }
    
    func setIsWrong() {
        isWrong = nameTextFieldClear == "" || translateTextFieldClear == "" || (nameTextFieldClear == word.name && translateTextFieldClear == word.translate && transcriptionTextFieldClear == word.transcription && examplesTextFieldClear == word.examples && translateExamplesTextFieldClear == word.translateExamples)
    }
}

struct EditWordView_Previews: PreviewProvider {
    static var previews: some View {
        EditWordView(idDictionary: "1", word: WordModel(name: "car", translate: "машина"))
            .environmentObject(DictionaryViewModel())
    }
}
