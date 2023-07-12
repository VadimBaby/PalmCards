//
//  SettingsView.swift
//  PalmCards
//
//  Created by Вадим Мартыненко on 06.07.2023.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var settings: Settings
    
    var body: some View {
        NavigationStack{
            ZStack {
                BackgroundColor()
                
                List {
                    Section("Игра") {
                        Toggle("Показывать сначала перевод", isOn: $settings.firstShowTranslate)
                        Toggle("Скрывать примеры", isOn: $settings.hideExample)
                        Picker("Выбрать режим игры", selection: $settings.selectTypeOfGame)
                        {
                            ForEach(settings.getAllCasesTypesGame(), id: \.self) { value in
                                Text(value.localizedName)
                                    .tag(value)
                            }
                        }
                        .tint(Color.red)
                    }
                    .tint(Color.red)
                }
            }
            .navigationTitle("Настройки")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(Settings())
    }
}
