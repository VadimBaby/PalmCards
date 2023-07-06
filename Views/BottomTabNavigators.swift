//
//  BottomTabNavigators.swift
//  PalmCards
//
//  Created by Вадим Мартыненко on 06.07.2023.
//

import SwiftUI

struct BottomTabNavigators: View {
    @State var selectView: Int = 0
    
    var body: some View {
        TabView(selection: $selectView) {
            DictionaryView()
                .tabItem {
                    HStack {
                        Image(systemName: "book.fill")
                        Text("Словари")
                    }
                }
                .tag(0)
            
            PlayView()
                .tabItem {
                    HStack{
                        Image(systemName: "play.circle.fill")
                        Text("Играть")
                    }
                }
                .tag(1)
            
            SettingsView()
                .tabItem {
                    HStack {
                        Image(systemName: "gear")
                        Text("Настройки")
                    }
                }
                .tag(2)
        }
        .tint(Color.red)
    }
}

struct BottomTabNavigators_Previews: PreviewProvider {
    static var previews: some View {
        BottomTabNavigators()
    }
}
