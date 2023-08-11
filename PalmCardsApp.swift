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
    @StateObject var settings: Settings = Settings()
    
    @StateObject var remindNotificationManager = RemindNotificationManager()
    
    var body: some Scene {
        WindowGroup {
            BottomTabNavigators()
                .environmentObject(dictionaryViewModel)
                .environmentObject(settings)
                .environmentObject(remindNotificationManager)
        }
    }
}
