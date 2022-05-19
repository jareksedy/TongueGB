//
//  Temp.swift
//  ЯзыкЪ
//
//  Created by Ярослав on 05.05.2022.
//

import Foundation

class MockCardsProvider {
    func createMockCards() -> [Card] {
        //return []
        
        return [
            Card(word: "carnation",
                 translation: "гвоздика",
                 description: "kɑːˈneɪʃn",
                 category: CardsCategory(categoryKey: "Растения", categoryColor: nil, categoryImage: nil, userEmail: ""),
                 userEmail: ""),
            
            Card(word: "whistleblower",
                 translation: "осведомитель",
                 description: "ˈwɪslbləʊər",
                 category: CardsCategory(categoryKey: "Разное", categoryColor: nil, categoryImage: nil, userEmail: ""),
                 userEmail: ""),
            
            Card(word: "guinea pig",
                 translation: "морская свинка",
                 description: "ˈgɪnɪ pɪg",
                 category: CardsCategory(categoryKey: "Животные", categoryColor: nil, categoryImage: nil, userEmail: ""),
                 userEmail: ""),
            
            Card(word: "incantation",
                 translation: "заклинание",
                 description: "ɪnkænˈteɪʃn",
                 category: CardsCategory(categoryKey: "Разное", categoryColor: nil, categoryImage: nil, userEmail: ""),
                 userEmail: ""),
            
            Card(word: "extraterrestrial",
                 translation: "внеземной",
                 description: "ekstrətəˈrestrɪəl",
                 category: CardsCategory(categoryKey: "Разное", categoryColor: nil, categoryImage: nil, userEmail: ""),
                 userEmail: ""),
            
            Card(word: "route",
                 translation: "маршрут",
                 description: "ruːt",
                 category: CardsCategory(categoryKey: "Путешествия", categoryColor: nil, categoryImage: nil, userEmail: ""),
                 userEmail: ""),
                        
            Card(word: "chimpanzee",
                 translation: "шимпанзе",
                 description: "ʧɪmpænˈziː",
                 category: CardsCategory(categoryKey: "Животные", categoryColor: nil, categoryImage: nil, userEmail: ""),
                 userEmail: ""),
            
            Card(word: "schnitzel",
                 translation: "шницель",
                 description: "ʃnɪtsl",
                 category: CardsCategory(categoryKey: "Еда", categoryColor: nil, categoryImage: nil, userEmail: ""),
                 userEmail: ""),
            
            Card(word: "wanderlust",
                 translation: "страсть к путешествиям",
                 description: "ˈwɒndəlʌst",
                 category: CardsCategory(categoryKey: "Путешествия", categoryColor: nil, categoryImage: nil, userEmail: ""),
                 userEmail: ""),
            
            Card(word: "heron",
                 translation: "цапля",
                 description: "ˈherən",
                 category: CardsCategory(categoryKey: "Животные", categoryColor: nil, categoryImage: nil, userEmail: ""),
                 userEmail: ""),
            
            Card(word: "hamster",
                 translation: "хомячок",
                 description: "ˈhæmstə",
                 category: CardsCategory(categoryKey: "Животные", categoryColor: nil, categoryImage: nil, userEmail: ""),
                 userEmail: ""),
            
            Card(word: "custard",
                 translation: "заварной крем",
                 description: "ˈkʌstəd",
                 category: CardsCategory(categoryKey: "Еда", categoryColor: nil, categoryImage: nil, userEmail: ""),
                 userEmail: ""),
            
            Card(word: "heather",
                 translation: "вереск",
                 description: "ˈheðə",
                 category: CardsCategory(categoryKey: "Растения", categoryColor: nil, categoryImage: nil, userEmail: ""),
                 userEmail: ""),
        ].shuffled()
    }
}
