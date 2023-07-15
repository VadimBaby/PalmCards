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
}
