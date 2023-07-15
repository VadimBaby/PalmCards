//
//  CardsPlayingView.swift
//  PalmCards
//
//  Created by Вадим Мартыненко on 15.07.2023.
//

import SwiftUI

struct CardsPlayingView: View {
    
    @EnvironmentObject var dictionaryViewModel: DictionaryViewModel
    @EnvironmentObject var settings: Settings
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct CardsPlayingView_Previews: PreviewProvider {
    static var previews: some View {
        CardsPlayingView()
            .environmentObject(DictionaryViewModel())
            .environmentObject(Settings())
    }
}
