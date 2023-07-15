//
//  CardsGameLogic.swift
//  PalmCards
//
//  Created by Вадим Мартыненко on 15.07.2023.
//

import Foundation

class CardsGameLogic: ObservableObject {
    
    @Published var shuffleWords: [WordModel] = []
    @Published var countWords: Int = 0
    @Published var indexShuffleWords: Int = 0
    @Published var title: String = ""
    @Published var upTitle: String = ""
    @Published var downTitle: String = ""
    @Published var countRightAnswers: Int = 0
    @Published var countWrongAnswers: Int = 0
    @Published var showResults: Bool = false
    @Published var firstShowTranslate: Bool = false
    @Published var hideExample: Bool = false
    
    var lastIndexElement = 0
    
    enum GuessMoment {
        case rotate
        case select
    }
    
    @Published var guessMoment: GuessMoment = .rotate
    
    func startGame(shuffledWords: [WordModel], setFirstShowTranslate: Bool, setHideExample: Bool){
        firstShowTranslate = setFirstShowTranslate
        hideExample = setHideExample
        shuffleWords = shuffledWords.shuffled()
        countWords = shuffledWords.count
        title = firstShowTranslate ? shuffleWords[0].translate : shuffleWords[0].name
        upTitle = firstShowTranslate ? shuffleWords[0].translateExamples : shuffleWords[0].examples
        downTitle = firstShowTranslate ? "" : shuffleWords[0].transcription
        lastIndexElement = shuffleWords.count - 1
    }
    
    func getPercentRightAnswers() -> CGFloat {
        return CGFloat(Double(countRightAnswers) / Double(lastIndexElement + 1))
    }
    
    func pressFlipButton() {
        upTitle = getUpTitleAfterPressFlipButton()
        title = getTitleAfterPressFlipButton()
        downTitle = getDownTitleAfterPressFlipButton()
    }
    
    func pressCheckMarkButton() {
        toggleGuessMoment()
        
        if indexShuffleWords <= lastIndexElement  {
            countRightAnswers += 1
        }
        
        guard shuffleWords.count - 1 > indexShuffleWords else { showResults = true; return }
        
        indexShuffleWords += 1
        
        upTitle = getUpTitleAfterPressMarkButton()
        title = getTitleAfterPressMarkButton()
        downTitle = getDownTitleAfterPressMarkButton()
        
        countWords -= 1
    }
    
    func toggleGuessMoment() {
        if guessMoment == .select {
            guessMoment = .rotate
        } else {
            guessMoment = .select
        }
    }
    
    // After Press Flip Button
    
    private func getUpTitleAfterPressFlipButton() -> String {
        guard !hideExample else { return "" }
        
        return firstShowTranslate ? shuffleWords[indexShuffleWords].examples : shuffleWords[indexShuffleWords].translateExamples
    }
    
    private func getTitleAfterPressFlipButton() -> String {
        return firstShowTranslate ? shuffleWords[indexShuffleWords].name : shuffleWords[indexShuffleWords].translate
    }
    
    private func getDownTitleAfterPressFlipButton() -> String {
        return firstShowTranslate ? shuffleWords[indexShuffleWords].transcription : ""
    }
    
    // After Press Mark Button
    
    private func getUpTitleAfterPressMarkButton() -> String {
        guard !hideExample else { return "" }
        
        return firstShowTranslate ? shuffleWords[indexShuffleWords].translateExamples : shuffleWords[indexShuffleWords].examples
    }
    
    private func getTitleAfterPressMarkButton() -> String {
        return firstShowTranslate ? shuffleWords[indexShuffleWords].translate : shuffleWords[indexShuffleWords].name
    }
    
    private func getDownTitleAfterPressMarkButton() -> String {
        return firstShowTranslate ? "" : shuffleWords[indexShuffleWords].transcription
    }
}
