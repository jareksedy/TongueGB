//
//  Temp.swift
//  ЯзыкЪ
//
//  Created by Ярослав on 05.05.2022.
//

import UIKit

// -- remove this later --
//struct Card {
//    let word: String
//    let translation: String
//    let description: String?
//    let category: Category
//    let userEmail: String
//}
//
//struct Category {
//    let categoryKey: String
//    let categoryColor: String?
//    let categoryImage: String?
//}
// -- remove his later --

class TempUICardMockProvider {
    func createMockCards() -> [Card] {
        //return []
        
        return [
            Card(word: "carnation",
                 translation: "гвоздика",
                 description: "kɑːˈneɪʃn",
                 category: CardsCategory(categoryKey: "Растения", categoryColor: nil, categoryImage: nil),
                 userEmail: ""),
            
            Card(word: "whistleblower",
                 translation: "осведомитель",
                 description: "ˈwɪslbləʊər",
                 category: CardsCategory(categoryKey: "Разное", categoryColor: nil, categoryImage: nil),
                 userEmail: ""),
            
            Card(word: "guinea pig",
                 translation: "морская свинка",
                 description: "ˈgɪnɪ pɪg",
                 category: CardsCategory(categoryKey: "Животные", categoryColor: nil, categoryImage: nil),
                 userEmail: ""),
            
            Card(word: "incantation",
                 translation: "заклинание",
                 description: "ɪnkænˈteɪʃn",
                 category: CardsCategory(categoryKey: "Разное", categoryColor: nil, categoryImage: nil),
                 userEmail: ""),
            
            Card(word: "extraterrestrial",
                 translation: "внеземной",
                 description: "ekstrətəˈrestrɪəl",
                 category: CardsCategory(categoryKey: "Разное", categoryColor: nil, categoryImage: nil),
                 userEmail: ""),
            
            Card(word: "route",
                 translation: "маршрут",
                 description: "ruːt",
                 category: CardsCategory(categoryKey: "Путешествия", categoryColor: nil, categoryImage: nil),
                 userEmail: ""),
                        
            Card(word: "chimpanzee",
                 translation: "шимпанзе",
                 description: "ʧɪmpænˈziː",
                 category: CardsCategory(categoryKey: "Животные", categoryColor: nil, categoryImage: nil),
                 userEmail: ""),
            
            Card(word: "schnitzel",
                 translation: "шницель",
                 description: "ʃnɪtsl",
                 category: CardsCategory(categoryKey: "Еда", categoryColor: nil, categoryImage: nil),
                 userEmail: ""),
            
            Card(word: "wanderlust",
                 translation: "страсть к путешествиям",
                 description: "ˈwɒndəlʌst",
                 category: CardsCategory(categoryKey: "Путешествия", categoryColor: nil, categoryImage: nil),
                 userEmail: ""),
            
            Card(word: "heron",
                 translation: "цапля",
                 description: "ˈherən",
                 category: CardsCategory(categoryKey: "Животные", categoryColor: nil, categoryImage: nil),
                 userEmail: "")
        ].shuffled()
    }
}
