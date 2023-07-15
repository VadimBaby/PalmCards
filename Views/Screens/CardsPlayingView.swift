//
//  CardsPlayingView.swift
//  PalmCards
//
//  Created by Вадим Мартыненко on 15.07.2023.
//

import SwiftUI

struct CardsPlayingView: View {
    let selectDictionaries: [String]
    let listWords: [WordModel]
    
    @EnvironmentObject var dictionaryViewModel: DictionaryViewModel
    @EnvironmentObject var settings: Settings
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.colorScheme) var colorScheme
    
    @State var animate: Double = 0
    @State var disableButtons: Bool = false
    @State var firstOpen: Bool = false
    
    @StateObject var gameLogic: CardsGameLogic = CardsGameLogic()
    
    var body: some View {
        ZStack{
            BackgroundColor()
            
            if !gameLogic.showResults {
                GameView
            } else {
                ResultView(
                    countRigthAnswers: gameLogic.countRightAnswers,
                    countWrongAnswers: gameLogic.countWrongAnswers,
                    percentRightAnswers: gameLogic.getPercentRightAnswers()
                ) {
                    dismiss()
                }
            }
            
        }
        .navigationBarBackButtonHidden(true)
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
                gameLogic.startGame(shuffledWords: listWords, setFirstShowTranslate: settings.firstShowTranslate, setHideExample: settings.hideExample)
                firstOpen = true
            }
        }
    }
    
    var GameView: some View {
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
            .padding()
            Spacer()
            
            RoundedRectangle(cornerRadius: 15)
                .fill(colorScheme == .dark ? Color.white.opacity(0.2) : Color.white)
                .overlay(
                    VStack{
                        Text(gameLogic.upTitle)
                        Spacer()
                        Text(gameLogic.title)
                            .font(.title)
                        Spacer()
                        Text(gameLogic.downTitle)
                    }
                        .padding(.vertical)
                )
                .frame(maxWidth: .infinity)
                .frame(height: 300)
                .padding(.horizontal)
                .rotation3DEffect(.degrees(animate), axis: (0, 1, 0))
            
            Spacer()
            if gameLogic.guessMoment == .rotate {
                nextButton
            } else {
                xmarkAndCheckmarkButtons
            }
        }
    }
    
    // buttons
    
    var nextButton: some View {
        HStack{
            Button(action: {
                animateRotateButton()
            }, label: {
                Text("Повернуть")
                    .foregroundColor(Color.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 55)
                    .background(disableButtons ? Color.gray.opacity(0.2) : Color.blue)
                    .cornerRadius(5)
            })
            .disabled(disableButtons)
        }
        .padding()
    }
    
    var xmarkAndCheckmarkButtons: some View {
        HStack(spacing: 50){
            Button(action: {
                gameLogic.pressXmarkButton()
            }, label: {
                Image(systemName: "xmark")
                    .font(.title)
                    .foregroundColor(.white)
                    .padding(.horizontal, 30)
                    .frame(height: 55)
                    .background(disableButtons ? Color.gray.opacity(0.2) : Color.red)
                    .cornerRadius(10)
            })
            .disabled(disableButtons)
            
            Button(action: {
                gameLogic.pressCheckMarkButton()
            }, label: {
                Image(systemName: "checkmark")
                    .font(.title)
                    .foregroundColor(Color.white)
                    .padding(.horizontal, 30)
                    .frame(height: 55)
                    .background(disableButtons ? Color.gray.opacity(0.2) : Color.green)
                    .cornerRadius(10)
            })
            .disabled(disableButtons)
        }
        .padding()
    }
    
    func animateRotateButton() {
        gameLogic.toggleGuessMoment()
        
        disableButtons = true
        
        withAnimation(.linear(duration: 0.2)){
            animate = -90
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute:
        {
            animate = 90
            gameLogic.pressFlipButton()
        })
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.21, execute:
        {
            withAnimation(.linear(duration: 0.2)){
                animate = 0
            }
        })
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.41, execute: {
            disableButtons = false
        })
    }
}

struct CardsPlayingView_Previews: PreviewProvider {
    static var previews: some View {
        CardsPlayingView(selectDictionaries: ["1"], listWords: [WordModel(name: "ura", translate: "dhit", examples: "adfs")])
            .environmentObject(DictionaryViewModel())
            .environmentObject(Settings())
    }
}
