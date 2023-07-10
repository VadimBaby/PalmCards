//
//  EditButtonComponent.swift
//  PalmCards
//
//  Created by Вадим Мартыненко on 10.07.2023.
//

import SwiftUI

struct EditButtonComponent: View {
    @Binding var editMode: EditMode
    
    var body: some View {
        Button {
            toggleEditMode()
        } label: {
            Text(editMode == .inactive ? "Редактировать" : "Готово")
                .foregroundColor(Color.red)
        }
        .tint(Color.red)
    }
    
    func toggleEditMode() {
        if editMode == .active {
            editMode = .inactive
        } else {
            editMode = .active
        }
    }
}

struct EditButtonComponent_Previews: PreviewProvider {
    static var previews: some View {
        EditButtonComponent(editMode: .constant(.inactive))
    }
}
