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
            Card(word: "carnation",
                 translation: "гвоздика",
                 description: "kɑːˈneɪʃn",
                 category: Category(categoryKey: "Растения", categoryColor: nil, categoryImage: nil),
                 userEmail: ""),
            
            Card(word: "whistleblower",
                 translation: "осведомитель",
                 description: "ˈwɪslbləʊər",
                 category: Category(categoryKey: "Разное", categoryColor: nil, categoryImage: nil),
                 userEmail: ""),
            
            Card(word: "guinea pig",
                 translation: "морская свинка",
                 description: "ˈgɪnɪ pɪg",
                 category: Category(categoryKey: "Животные", categoryColor: nil, categoryImage: nil),
                 userEmail: ""),
            
            Card(word: "incantation",
                 translation: "заклинание",
                 description: "ɪnkænˈteɪʃn",
                 category: Category(categoryKey: "Разное", categoryColor: nil, categoryImage: nil),
                 userEmail: ""),
            
            Card(word: "extraterrestrial",
                 translation: "внеземной",
                 description: "ekstrətəˈrestrɪəl",
                 category: Category(categoryKey: "Разное", categoryColor: nil, categoryImage: nil),
                 userEmail: ""),
            
            Card(word: "route",
                 translation: "маршрут",
                 description: "ruːt",
                 category: Category(categoryKey: "Путешествия", categoryColor: nil, categoryImage: nil),
                 userEmail: ""),
                        
            Card(word: "chimpanzee",
                 translation: "шимпанзе",
                 description: "ʧɪmpænˈziː",
                 category: Category(categoryKey: "Животные", categoryColor: nil, categoryImage: nil),
                 userEmail: ""),
            
            Card(word: "schnitzel",
                 translation: "шницель",
                 description: "ʃnɪtsl",
                 category: Category(categoryKey: "Еда", categoryColor: nil, categoryImage: nil),
                 userEmail: ""),
            
            Card(word: "wanderlust",
                 translation: "страсть к путешествиям",
                 description: "ˈwɒndəlʌst",
                 category: Category(categoryKey: "Путешествия", categoryColor: nil, categoryImage: nil),
                 userEmail: ""),
            
            Card(word: "heron",
                 translation: "цапля",
                 description: "ˈherən",
                 category: Category(categoryKey: "Животные", categoryColor: nil, categoryImage: nil),
                 userEmail: "")
        ].shuffled()
    }
}
