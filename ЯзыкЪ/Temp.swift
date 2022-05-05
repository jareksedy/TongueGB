//
//  Temp.swift
//  ЯзыкЪ
//
//  Created by Ярослав on 05.05.2022.
//

import UIKit

// -- remove this later --
struct Card {
    let word: String
    let translation: String
    let description: String?
    let category: Category
    let userEmail: String
}

struct Category {
    let categoryKey: String
    let categoryColor: String?
    let categoryImage: String?
}
// -- remove his later --

class TempUICardMockProvider {
    func createMockCards() -> [Card] {
        return [
            Card(word: "swoop",
                 translation: "наскок",
                 description: "swuːp",
                 category: Category(categoryKey: "Разное", categoryColor: nil, categoryImage: nil),
                 userEmail: ""),
            
            Card(word: "tabby",
                 translation: "полосатый",
                 description: "ˈtæbɪ",
                 category: Category(categoryKey: "Животные", categoryColor: nil, categoryImage: nil),
                 userEmail: ""),
            
            Card(word: "switchman",
                 translation: "стрелочник",
                 description: "ˈswɪʧmən",
                 category: Category(categoryKey: "Транспорт", categoryColor: nil, categoryImage: nil),
                 userEmail: ""),
            
            Card(word: "sultry",
                 translation: "знойный",
                 description: "ˈsʌltrɪ",
                 category: Category(categoryKey: "Погода", categoryColor: nil, categoryImage: nil),
                 userEmail: "")
        ]
//        return [
//            Card(word: "Juggernaut",
//                 translation: "Джаггернаут",
//                 description: "ˈʤʌgənɔːt",
//                 category: Category(categoryKey: "Разное", categoryColor: nil, categoryImage: nil),
//                 userEmail: ""),
//
//            Card(word: "Trifle",
//                 translation: "Трайфл",
//                 description: "traɪfl",
//                 category: Category(categoryKey: "Еда", categoryColor: nil, categoryImage: nil),
//                 userEmail: ""),
//
//            Card(word: "Syllabub",
//                 translation: "Силлабаб",
//                 description: "ˈsiləˌbəb",
//                 category: Category(categoryKey: "Еда", categoryColor: nil, categoryImage: nil),
//                 userEmail: ""),
//
//            Card(word: "Wanderlust",
//                 translation: "Вандерласт",
//                 description: "ˈwɒndəlʌst",
//                 category: Category(categoryKey: "Путешествия", categoryColor: nil, categoryImage: nil),
//                 userEmail: "")
//        ]
    }
}
