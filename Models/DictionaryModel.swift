//
//  DictionaryModel.swift
//  PalmCards
//
//  Created by Вадим Мартыненко on 06.07.2023.
//

import Foundation

struct DictionaryModel: Identifiable, Codable {
    var id: String = UUID().uuidString
    var name: String
    var words: [WordModel] = []
}
