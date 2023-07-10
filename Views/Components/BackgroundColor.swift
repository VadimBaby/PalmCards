//
//  BackgroundColor.swift
//  PalmCards
//
//  Created by Вадим Мартыненко on 10.07.2023.
//

import SwiftUI

struct BackgroundColor: View {
    var body: some View {
        Color("backgroundColor")
            .ignoresSafeArea()
    }
}

struct BackgroundColor_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundColor()
    }
}
