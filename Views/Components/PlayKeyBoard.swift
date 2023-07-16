//
//  PlayKeyBoard.swift
//  PalmCards
//
//  Created by Вадим Мартыненко on 16.07.2023.
//

import SwiftUI

struct PlayKeyBoard: View {
    
    @Binding var text: String
    @Binding var disableButtonNext: Bool
    @Binding var allButtonsDisabled: Bool
    
    @Environment(\.colorScheme) var colorScheme
    
    var pressNextButton: () -> ()
    
    let firstLevel = "q w e r t y u i o p".components(separatedBy: " ")
    let middleLevel = "a s d f g h j k l".components(separatedBy: " ")
    let thirdLevel = "z x c v b n m ,".components(separatedBy: " ")
    
    var body: some View {
        VStack{
            HStack(spacing: 5){
                ForEach(firstLevel, id: \.self) { letter in
                    LetterButton(letter: letter, text: $text, allButtonsDisabled: $allButtonsDisabled)
                }
            }
            HStack{
                ForEach(middleLevel, id: \.self) { letter in
                    LetterButton(letter: letter, text: $text, allButtonsDisabled: $allButtonsDisabled)
                }
            }
            HStack{
                ForEach(thirdLevel, id: \.self) { letter in
                    LetterButton(letter: letter, text: $text, allButtonsDisabled: $allButtonsDisabled)
                }
            }
            HStack{
                Button(action: {
                    self.text = String(self.text.dropLast())
                }) {
                    RoundedRectangle(cornerRadius: 5)
                        .fill(allButtonsDisabled ? Color.gray : Color.red)
                        .frame(width: 83, height: 33)
                        .overlay {
                            Text("стереть")
                                .foregroundColor(Color.white)
                        }
                }
                .disabled(allButtonsDisabled)
                Spacer()
                Button(action: {
                    self.text += " "
                }) {
                    RoundedRectangle(cornerRadius: 5)
                        .fill(allButtonsDisabled ? Color.gray : Color.primary)
                        .frame(width: 83, height: 33)
                        .overlay {
                            Text("пробел")
                                .foregroundColor(colorScheme == .dark ? Color.black : Color.white)
                        }
                }
                .disabled(allButtonsDisabled)
                Spacer()
                Button(action: {
                    if !disableButtonNext {
                        pressNextButton()
                    }
                }) {
                    RoundedRectangle(cornerRadius: 5)
                        .fill(disableButtonNext || allButtonsDisabled ? Color.gray : Color.blue)
                        .frame(width: 83, height: 33)
                        .overlay {
                            Text("дальше")
                                .foregroundColor(Color.white)
                        }
                }
                .deleteDisabled(disableButtonNext || allButtonsDisabled)
            }
            .padding(.horizontal)
        }
        .padding(.bottom)
    }
}

struct LetterButton: View {
    
    var letter: String
    
    @Binding var text: String
    @Binding var allButtonsDisabled: Bool
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        Button(action: {
            self.text += letter
        }) {
            RoundedRectangle(cornerRadius: 5)
                .fill(allButtonsDisabled ? Color.gray : Color.primary)
                .frame(width: 33, height: 33)
                .overlay {
                    Text(letter)
                        .foregroundColor(colorScheme == .dark ? Color.black : Color.white)
                }
        }
        .disabled(allButtonsDisabled)
    }
}

struct PlayKeyBoard_Previews: PreviewProvider {
    static var previews: some View {
        PlayKeyBoard(text: .constant(""), disableButtonNext: .constant(false), allButtonsDisabled: .constant(false)){}
    }
}
