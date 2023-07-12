//
//  Settings.swift
//  PalmCards
//
//  Created by Вадим Мартыненко on 12.07.2023.
//

import Foundation

class Settings: ObservableObject {
    
    @Published var firstShowTranslate: Bool = false {
        didSet {
            UserDefaults.standard.set(firstShowTranslate, forKey: "firstShowTranslate")
        }
    }
    
    init() {
        firstShowTranslate = UserDefaults.standard.bool(forKey: "firstShowTranslate")
    }
}
