//
//  NoItemListWordsView.swift
//  PalmCards
//
//  Created by Вадим Мартыненко on 10.07.2023.
//

import SwiftUI

struct NoItemListWordsView: View {
    @State var animateOpacity: Bool = false
    
    var body: some View {
        ScrollView{
            VStack{
                Text("У вас нет слов")
                    .bold()
                    .font(.title)
                    .foregroundColor(.primary)
                Text("Вы можете добавить их")
                    .foregroundColor(.secondary)
                    .padding(.bottom)
                Spacer()
            }
            .padding(.vertical)
            .opacity(animateOpacity ? 1 : 0)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onAppear{
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
                withAnimation(.linear(duration: 1)){
                    animateOpacity = true
                }
            })
        }
    }
}

struct NoItemListWordsView_Previews: PreviewProvider {
    static var previews: some View {
        NoItemListWordsView()
    }
}
