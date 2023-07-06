//
//  PalmCardsApp.swift
//  PalmCards
//
//  Created by Вадим Мартыненко on 06.07.2023.
//

import SwiftUI

@main
struct PalmCardsApp: App {
    @StateObject var dictionaryViewModel: DictionaryViewModel = DictionaryViewModel()
    
    var body: some Scene {
        WindowGroup {
            BottomTabNavigators()
                .environmentObject(dictionaryViewModel)
        }
    }
}
