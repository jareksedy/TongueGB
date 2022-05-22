//
//  DictionaryRequest.swift
//  ЯзыкЪ
//
//  Created by Ярослав on 21.05.2022.
//

import Foundation

// MARK: - Dictionary request
struct DictionaryRequest: Codable {
    let key, lang, text: String
}
