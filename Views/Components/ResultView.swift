//
//  ResultView.swift
//  PalmCards
//
//  Created by Вадим Мартыненко on 16.07.2023.
//

import SwiftUI

struct ResultView: View {
    var countRigthAnswers: Int
    var countWrongAnswers: Int
    var percentRightAnswers: CGFloat
    
    var pressCloseButton: () -> Void
    
    @State var percent: CGFloat = 0
    
    var body: some View {
        VStack {
            ZStack{
                Text("\(Int(percentRightAnswers * 100))%")
                Circle()
                    .stroke(.red, lineWidth: 20)
                
                Circle()
                    .trim(from: 0, to: percent)
                    .stroke(.green, lineWidth: 20)
                    .rotationEffect(.degrees(-90))
                    .animation(.linear(duration: 1), value: percent)
            }
            .padding()
            .padding(.horizontal, 50)
            
            VStack(alignment: .leading){
                HStack{
                    Text("Правильно угадано: \(countRigthAnswers)")
                        .foregroundColor(Color.green)
                    Spacer()
                }
                Text("Неправильно угадано: \(countWrongAnswers)")
                    .foregroundColor(Color.red)
            }
            .frame(maxWidth: .infinity)
            .font(.title2)
            .padding()
            
            Spacer()
            
            Button(action: pressCloseButton, label: {
                Text("Закрыть")
                    .foregroundColor(Color.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 55)
                    .background(Color.blue)
                    .cornerRadius(10)
                    .padding()
            })
        }
        .onAppear{
            percent = percentRightAnswers
        }
    }
}

struct ResultView_Previews: PreviewProvider {
    static var previews: some View {
        ResultView(countRigthAnswers: 1, countWrongAnswers: 1, percentRightAnswers: 1){}
    }
}

