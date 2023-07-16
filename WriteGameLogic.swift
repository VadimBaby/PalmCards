//
//  WriteGameLogic.swift
//  PalmCards
//
//  Created by Вадим Мартыненко on 16.07.2023.
//

import Foundation

class WriteGameLogic: ObservableObject {
    @Published var writingWord: String = ""
    @Published var showingTranslate: String = ""
    @Published var rightWord: String = ""
    @Published var shuffleWords: [WordModel] = []
    @Published var countWords: Int = 0
    @Published var indexShuffleWords: Int = 0
    @Published var countRightAnswers: Int = 0
    @Published var countWrongAnswers: Int = 0
    @Published var showResults: Bool = false
    @Published var showingTranscription: String = ""
    
    var lastIndexElement = 0
    
    func startGame(listWords: [WordModel]){
        shuffleWords = listWords.shuffled()
        countWords = listWords.count
        showResults = false
        indexShuffleWords = 0
        writingWord = ""
        showingTranslate = shuffleWords[0].translate
        rightWord = shuffleWords[0].name
        showingTranscription = shuffleWords[0].transcription
        lastIndexElement = shuffleWords.count - 1
    }
    
    func getPercentRightAnswers() -> CGFloat {
        return CGFloat(Double(countRightAnswers) / Double(lastIndexElement + 1))
    }
    
    func pressNextButton() {
        if indexShuffleWords <= lastIndexElement  {
            countRightAnswers += 1
        }
        
        guard shuffleWords.count - 1 > indexShuffleWords else { showResults = true; return }
        
        guessNextWord()
    }
    
    func pressMissButton() {
        countWrongAnswers += 1
        shuffleWords.append(shuffleWords[indexShuffleWords])
        countWords += 1
        
        guard shuffleWords.count - 1 > indexShuffleWords else { showResults = true; return }
        
        guessNextWord()
    }
    
    func guessNextWord(){
        indexShuffleWords += 1
        writingWord = ""
        showingTranslate = shuffleWords[indexShuffleWords].translate
        rightWord = shuffleWords[indexShuffleWords].name
        showingTranscription = shuffleWords[indexShuffleWords].transcription
        countWords -= 1
    }
}
