//
//  AddWordSheet.swift
//  PalmCards
//
//  Created by Вадим Мартыненко on 09.07.2023.
//

import SwiftUI

struct AddWordSheet: View {
    @Binding var showAddSheet: Bool
    var id: String
    @EnvironmentObject var dictionaryViewModel: DictionaryViewModel
    @Environment(\.dismiss) var dismiss
    
    @State var nameTextField: String = ""
    @State var translateTextField: String = ""
    @State var examplesTextField: String = ""
    @State var translateExamplesTextField: String = ""
    @State var transcriptionTextField: String = ""
    
    @State var showProgressView: Bool = false
    
    enum FocusedTextField {
        case name
        case translate
        case examples
        case translateExamples
        case transcription
    }
    
    @FocusState var focusedTextField: FocusedTextField?
    
    var body: some View {
        ZStack{
            VStack{
                HStack{
                    Spacer()
                    Button(action: {
                        self.showAddSheet = false
                    }, label: {
                        Image(systemName: "xmark")
                            .font(.title)
                            .tint(Color.primary)
                    })
                }
                .padding()
                Spacer()
                
                TextField("Слово", text: $nameTextField)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .frame(height: 55)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(15)
                    .padding(.horizontal)
                    .focused($focusedTextField, equals: .name)
                    .onTapGesture {
                        focusedTextField = .name
                    }
                
                HStack {
                    TextField("Перевод", text: $translateTextField)
                        .frame(height: 55)
                        .padding(.leading)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(15)
                        .focused($focusedTextField, equals: .translate)
                        .onTapGesture {
                            focusedTextField = .translate
                    }
                }
                .frame(maxWidth: .infinity)
                .frame(height: 55)
                .padding(.horizontal)
                
                TextField("Транскрипция", text: $transcriptionTextField)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .frame(height: 55)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(15)
                    .padding(.horizontal)
                    .focused($focusedTextField, equals: .transcription)
                    .onTapGesture {
                        focusedTextField = .transcription
                    }
                
                TextField("Пример", text: $examplesTextField)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .frame(height: 55)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(15)
                    .padding(.horizontal)
                    .focused($focusedTextField, equals: .examples)
                    .onTapGesture {
                        focusedTextField = .examples
                    }
                
                TextField("Перевод примера", text: $translateExamplesTextField)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .frame(height: 55)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(15)
                    .padding(.horizontal)
                    .focused($focusedTextField, equals: .translateExamples)
                    .onTapGesture {
                        focusedTextField = .translateExamples
                    }
                
                Button(action: {
                    dictionaryViewModel.addWords(
                        name: nameTextField.trimmingCharacters(in: .whitespacesAndNewlines),
                        translate: translateTextField.trimmingCharacters(in: .whitespacesAndNewlines),
                        transcription: transcriptionTextField.trimmingCharacters(in: .whitespacesAndNewlines),
                        examples: examplesTextField.trimmingCharacters(in: .whitespacesAndNewlines),
                        translateExamples: translateExamplesTextField.trimmingCharacters(in: .whitespacesAndNewlines),
                        id: id)
                    self.showAddSheet = false
                }, label: {
                    Text("Добавить")
                        .frame(maxWidth: .infinity)
                        .frame(height: 55)
                        .background(nameTextField.trimmingCharacters(in: .whitespacesAndNewlines) == "" || translateTextField.trimmingCharacters(in: .whitespacesAndNewlines) == "" ? Color.gray.opacity(0.2) : Color.blue)
                        .cornerRadius(15)
                        .tint(Color.white)
                })
                .padding()
                .disabled(nameTextField.trimmingCharacters(in: .whitespacesAndNewlines) == "" || translateTextField.trimmingCharacters(in: .whitespacesAndNewlines) == "" ? true : false)
                Spacer()
            }
        }
        .onTapGesture {
            focusedTextField = nil
        }
    }
}

struct AddWordSheet_Previews: PreviewProvider {
    static var previews: some View {
        AddWordSheet(showAddSheet: .constant(true), id: "asd")
            .environmentObject(DictionaryViewModel())
    }
}
