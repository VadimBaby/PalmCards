//
//  Settings.swift
//  PalmCards
//
//  Created by Вадим Мартыненко on 12.07.2023.
//

import Foundation
import SwiftUI

class Settings: ObservableObject {
    
    public enum TypesGame: String, Equatable, CaseIterable {
        case cards
        case write
        
        var localizedName: LocalizedStringKey {
            if rawValue == "cards" {
                return LocalizedStringKey("Карточки")
            } else {
                return LocalizedStringKey("Письмо")
            }
        }
    }
    
    @Published var firstShowTranslate: Bool = false {
        didSet {
            UserDefaults.standard.set(firstShowTranslate, forKey: "firstShowTranslate")
        }
    }
    
    @Published var hideExample: Bool = false {
        didSet {
            UserDefaults.standard.set(hideExample, forKey: "hideExample")
        }
    }
    
    @Published var selectTypeOfGame: TypesGame = .cards {
        didSet {
            UserDefaults.standard.set(selectTypeOfGame.rawValue, forKey: "selectTypeOfGame")
        }
    }
    
    func getAllCasesTypesGame() -> [TypesGame] {
        return TypesGame.allCases
    }
    
    init() {
        firstShowTranslate = UserDefaults.standard.bool(forKey: "firstShowTranslate")
        hideExample = UserDefaults.standard.bool(forKey: "hideExample")
        
        if let checkSelectTypeOfGame = UserDefaults.standard.string(forKey: "selectTypeOfGame") {
            if checkSelectTypeOfGame == "cards" {
                selectTypeOfGame = .cards
            } else if checkSelectTypeOfGame == "writing" {
                selectTypeOfGame = .write
            }
        } else {
            selectTypeOfGame = .cards
        }
    }
}
