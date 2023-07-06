//
//  WordModel.swift
//  PalmCards
//
//  Created by Вадим Мартыненко on 06.07.2023.
//

import Foundation

struct WordModel: Identifiable, Codable {
    var id: String = UUID().uuidString
    var name: String
    var translate: String
    var examples: String = ""
    var translateExamples: String = ""
    var transcription: String = ""
}
