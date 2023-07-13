//
//  PlayView.swift
//  PalmCards
//
//  Created by Вадим Мартыненко on 06.07.2023.
//

import SwiftUI

struct PlayView: View {
    @EnvironmentObject var dictionaryViewModel: DictionaryViewModel
    @EnvironmentObject var settings: Settings
    @State private var doCardsNavigate: Bool = false
    @State private var doWritingNavigate: Bool = false
    @State var chosenDictionaries: [String] = []

    let listOfTypeGames = ["cards", "write words"]
    
    var body: some View {
        NavigationStack{
            ZStack {
                BackgroundColor()
                
                VStack{
                    if dictionaryViewModel.listDictionaries.isEmpty {
                        NoItemDictionaryView()
                    } else {
                        VStack{
                            List {
                                ForEach(dictionaryViewModel.listDictionaries) { dictionary in
                                    Text(dictionary.name)
                                }
                            }
                            .frame(height: 400)
                        }
                    }
                    
                    Spacer()
                    
                    Button(action: {}) {
                        Text("Играть")
                            .tint(Color.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 55)
                            .background(Color.blue)
                            .cornerRadius(15)
                            .padding()
                    }
                }
            }
            .navigationTitle("Играть")
        }
    }
}

struct PlayView_Previews: PreviewProvider {
    static var previews: some View {
        PlayView()
            .environmentObject(DictionaryViewModel())
            .environmentObject(Settings())
    }
}
