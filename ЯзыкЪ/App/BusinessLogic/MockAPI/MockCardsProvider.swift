//
//  Temp.swift
//  ЯзыкЪ
//
//  Created by Ярослав on 05.05.2022.
//

import Foundation

class MockCardsProvider {
    func createMockCards() -> [CardFirebase] {
        //return []
        
        return [
            CardFirebase(word: "carnation",
                         translation: "гвоздика",
                         description: "kɑːˈneɪʃn",
                         category: CategoryFirebase(categoryName: "Растения"),
                         userEmail: ""),
            
            CardFirebase(word: "whistleblower",
                         translation: "осведомитель",
                         description: "ˈwɪslbləʊər",
                         category: CategoryFirebase(categoryName: "Разное"),
                         userEmail: ""),
            
            CardFirebase(word: "guinea pig",
                         translation: "морская свинка",
                         description: "ˈgɪnɪ pɪg",
                         category: CategoryFirebase(categoryName: "Животные"),
                         userEmail: ""),
            
            CardFirebase(word: "incantation",
                         translation: "заклинание",
                         description: "ɪnkænˈteɪʃn",
                         category: CategoryFirebase(categoryName: "Разное"),
                         userEmail: ""),
            
            CardFirebase(word: "extraterrestrial",
                         translation: "внеземной",
                         description: "ekstrətəˈrestrɪəl",
                         category: CategoryFirebase(categoryName: "Разное"),
                         userEmail: ""),
            
            CardFirebase(word: "route",
                         translation: "маршрут",
                         description: "ruːt",
                         category: CategoryFirebase(categoryName: "Путешествия"),
                         userEmail: ""),
            
            CardFirebase(word: "chimpanzee",
                         translation: "шимпанзе",
                         description: "ʧɪmpænˈziː",
                         category: CategoryFirebase(categoryName: "Животные"),
                         userEmail: ""),
            
            CardFirebase(word: "schnitzel",
                         translation: "шницель",
                         description: "ʃnɪtsl",
                         category: CategoryFirebase(categoryName: "Еда"),
                         userEmail: ""),
            
            CardFirebase(word: "wanderlust",
                         translation: "страсть к путешествиям",
                         description: "ˈwɒndəlʌst",
                         category: CategoryFirebase(categoryName: "Путешествия"),
                         userEmail: ""),
            
            CardFirebase(word: "heron",
                         translation: "цапля",
                         description: "ˈherən",
                         category: CategoryFirebase(categoryName: "Животные"),
                         userEmail: ""),
            
            CardFirebase(word: "hamster",
                         translation: "хомячок",
                         description: "ˈhæmstə",
                         category: CategoryFirebase(categoryName: "Животные"),
                         userEmail: ""),
            
            CardFirebase(word: "custard",
                         translation: "заварной крем",
                         description: "ˈkʌstəd",
                         category: CategoryFirebase(categoryName: "Еда"),
                         userEmail: ""),
            
            CardFirebase(word: "heather",
                         translation: "вереск",
                         description: "ˈheðə",
                         category: CategoryFirebase(categoryName: "Растения"),
                         userEmail: ""),
        ].shuffled()
    }
}
