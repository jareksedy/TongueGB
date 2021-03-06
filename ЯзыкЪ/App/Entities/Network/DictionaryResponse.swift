//
//  DictionaryResponse.swift
//  ЯзыкЪ
//
//  Created by Ярослав on 21.05.2022.
//

import Foundation

// MARK: - Dictionary response
struct DictionaryResponse: Codable {
    let def: [Definition]
}

// MARK: - Definition
struct Definition: Codable {
    let text, ts: String
    let tr: [Translation]
}

// MARK: - Translation
struct Translation: Codable {
    let text: String
}
