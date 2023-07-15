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
    
    @Environment(\.colorScheme) var colorScheme
    
    @StateObject var gameLogic: CardsGameLogic = CardsGameLogic()
    
    var body: some View {
        ZStack{
            BackgroundColor()
            
            if true {
                GameView
            } else {
                VStack{}
            }
            
        }
        .navigationBarBackButtonHidden(true)
    }
    
    var GameView: some View {
        VStack{
            HStack{
                Button(action: {}, label: {
                    Text("Завершить")
                        .font(.headline)
                        .foregroundColor(Color.white)
                        .padding(10)
                        .background(colorScheme == .dark ? Color.white.opacity(0.2) : Color.black)
                        .cornerRadius(5)
                })
                Spacer()
                Text("0")
            }
            .padding()
            Spacer()
            
            RoundedRectangle(cornerRadius: 15)
                .fill(colorScheme == .dark ? Color.white.opacity(0.2) : Color.white)
                .overlay(
                    VStack{
                        Text("showUpTitle")
                        Spacer()
                        Text("title")
                            .font(.title)
                        Spacer()
                        Text("donwTitle")
                    }
                        .padding(.vertical)
                )
                .frame(maxWidth: .infinity)
                .frame(height: 300)
                .padding(.horizontal)
                .rotation3DEffect(.degrees(0), axis: (0, 1, 0))
            
            Spacer()
            if true {
                nextButton
            } else {
                xmarkAndCheckmarkButtons
            }
        }
    }
    
    // buttons
    
    var nextButton: some View {
        HStack{
            Button(action: {}, label: {
                Text("Повернуть")
                    .foregroundColor(Color.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 55)
                    .background(false ? Color.gray.opacity(0.2) : Color.blue)
                    .cornerRadius(5)
            })
            .disabled(false)
        }
        .padding()
    }
    
    var xmarkAndCheckmarkButtons: some View {
        HStack(spacing: 50){
            Button(action: {}, label: {
                Image(systemName: "xmark")
                    .font(.title)
                    .foregroundColor(.white)
                    .padding(.horizontal, 30)
                    .frame(height: 55)
                    .background(false ? Color.gray.opacity(0.2) : Color.red)
                    .cornerRadius(10)
            })
            .disabled(false)
            
            Button(action: {}, label: {
                Image(systemName: "checkmark")
                    .font(.title)
                    .foregroundColor(Color.white)
                    .padding(.horizontal, 30)
                    .frame(height: 55)
                    .background(false ? Color.gray.opacity(0.2) : Color.green)
                    .cornerRadius(10)
            })
            .disabled(false)
        }
        .padding()
    }
}

struct CardsPlayingView_Previews: PreviewProvider {
    static var previews: some View {
        CardsPlayingView()
            .environmentObject(DictionaryViewModel())
            .environmentObject(Settings())
    }
}
