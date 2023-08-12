//
//  WritePlayingView.swift
//  PalmCards
//
//  Created by Вадим Мартыненко on 15.07.2023.
//

import SwiftUI


class HapticManager {
    static let instance = HapticManager()
    
    func success(isOffVibrate: Bool) {
        guard !isOffVibrate else { return }
        
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }
    
    func wrong(isOffVibrate: Bool) {
        guard !isOffVibrate else { return }
        
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.error)
    }
}

struct WritePlayingView: View {
    
    let selectDictionaries: [String]
    let listWords: [WordModel]
    
    @EnvironmentObject var dictionaryViewModel: DictionaryViewModel
    
    @EnvironmentObject var settings: Settings
    
    @StateObject var gameLogic: WriteGameLogic = WriteGameLogic()
    
    @State var disableButtonNext: Bool = false
    @State var firstOpen: Bool = false
    @State var allButtonsDisabled: Bool = false
    @State var textColor: Color = Color.primary
    @State var percent: CGFloat = 0
    @State var showConfirmDialog: Bool = false
    @State var showTranscription: Bool = false
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ZStack{
            if !gameLogic.showResults {
                GameView
            } else {
                ResultView(
                    selectDictionaries: selectDictionaries,
                    countRigthAnswers: gameLogic.countRightAnswers,
                    countWrongAnswers: gameLogic.countWrongAnswers,
                    percentRightAnswers: gameLogic.getPercentRightAnswers()){ dismiss() }
            }
        }
        .navigationBarBackButtonHidden(true)
        .confirmationDialog("Пропустить", isPresented: $showConfirmDialog, actions: {
            Button("Пропустить"){
                allButtonsDisabled = true
                gameLogic.writingWord = gameLogic.rightWord
                showTranscription = true

                DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                    gameLogic.writingWord = ""
                    showTranscription = false
                    gameLogic.pressMissButton()
                    allButtonsDisabled = false
                })
            }
            
            Button("Отменить", role: .cancel){
                showConfirmDialog = false
            }
        })
        .onAppear{
            var haveTheSameId: Bool = true
            
            selectDictionaries.forEach { item in
                if !dictionaryViewModel.listDictionaries.contains(where: {$0.id == item})
                {
                    haveTheSameId = false
                }
            }
            
            if !haveTheSameId {
                dismiss()
            } else if !firstOpen{
                gameLogic.startGame(listWords: listWords)
                firstOpen = true
            }
        }
    }
    
    var GameView: some View {
        VStack{
            VStack{
                HStack{
                    Button(action: {
                        dismiss()
                    }, label: {
                        Text("Завершить")
                            .font(.headline)
                            .foregroundColor(Color.white)
                            .padding(10)
                            .background(colorScheme == .dark ? Color.white.opacity(0.2) : Color.black)
                            .cornerRadius(5)
                    })
                    Spacer()
                    Text("\(gameLogic.countWords)")
                }
                .padding(.horizontal)
                VStack{
                    Text(gameLogic.showingTranslate)
                        .font(.title2)
                    Text(gameLogic.writingWord)
                        .foregroundColor(textColor)
                        .font(.title)
                    Text(showTranscription ? gameLogic.showingTranscription : "")
                    
                }
                .padding(.horizontal)
            }
            Spacer()
            VStack {
                HStack{
                    Button(action: {
                        showConfirmDialog = true
                    }) {
                        Text("пропустить")
                            .foregroundColor(Color.white)
                            .padding(10)
                            .background(allButtonsDisabled ? Color.gray : Color.orange)
                            .cornerRadius(15)
                    }
                    .disabled(allButtonsDisabled)
                }
                .padding()
                
                PlayKeyBoard(text: $gameLogic.writingWord, disableButtonNext: $disableButtonNext, allButtonsDisabled: $allButtonsDisabled, pressNextButton: pressNextButton)
            }
        }
    }
    
    func pressNextButton() {
        disableButtonNext = true
        
        if gameLogic.writingWord.trimmingCharacters(in: .whitespacesAndNewlines).lowercased() == gameLogic.rightWord.lowercased() {
            
            textColor = Color.green
            showTranscription = true
            
            HapticManager.instance.success(isOffVibrate: settings.isOffVibrate)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                textColor = Color.primary
                showTranscription = false
                gameLogic.pressNextButton()
            })
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {
                disableButtonNext = false
            })
            
        } else {
            textColor = Color.red
            
            HapticManager.instance.wrong(isOffVibrate: settings.isOffVibrate)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                textColor = Color.primary
                disableButtonNext = false
            })
        }
    }
}

struct WritePlayingView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            WritePlayingView(selectDictionaries: ["1"], listWords: [WordModel(name: "asd", translate: "asd")])
                .environmentObject(DictionaryViewModel())
                .environmentObject(Settings())
        }
    }
}
