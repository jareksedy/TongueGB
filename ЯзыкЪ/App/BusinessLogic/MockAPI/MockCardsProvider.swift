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
                         transcription: "kɑːˈneɪʃn",
                         category: "Растения",
                         userEmail: ""),
            
            CardFirebase(word: "whistleblower",
                         translation: "осведомитель",
                         transcription: "ˈwɪslbləʊər",
                         category: "Разное",
                         userEmail: ""),
            
            CardFirebase(word: "guinea pig",
                         translation: "морская свинка",
                         transcription: "ˈgɪnɪ pɪg",
                         category: "Животные",
                         userEmail: ""),
            
            CardFirebase(word: "incantation",
                         translation: "заклинание",
                         transcription: "ɪnkænˈteɪʃn",
                         category: "Разное",
                         userEmail: ""),
            
            CardFirebase(word: "extraterrestrial",
                         translation: "внеземной",
                         transcription: "ekstrətəˈrestrɪəl",
                         category: "Разное",
                         userEmail: ""),
            
            CardFirebase(word: "route",
                         translation: "маршрут",
                         transcription: "ruːt",
                         category: "Путешествия",
                         userEmail: ""),
            
            CardFirebase(word: "chimpanzee",
                         translation: "шимпанзе",
                         transcription: "ʧɪmpænˈziː",
                         category: "Животные",
                         userEmail: ""),
            
            CardFirebase(word: "schnitzel",
                         translation: "шницель",
                         transcription: "ʃnɪtsl",
                         category: "Еда",
                         userEmail: ""),
            
            CardFirebase(word: "wanderlust",
                         translation: "страсть к путешествиям",
                         transcription: "ˈwɒndəlʌst",
                         category: "Путешествия",
                         userEmail: ""),
            
            CardFirebase(word: "heron",
                         translation: "цапля",
                         transcription: "ˈherən",
                         category: "Животные",
                         userEmail: ""),
            
            CardFirebase(word: "hamster",
                         translation: "хомячок",
                         transcription: "ˈhæmstə",
                         category: "Животные",
                         userEmail: ""),
            
            CardFirebase(word: "custard",
                         translation: "заварной крем",
                         transcription: "ˈkʌstəd",
                         category: "Еда",
                         userEmail: ""),
            
            CardFirebase(word: "heather",
                         translation: "вереск",
                         transcription: "ˈheðə",
                         category: "Растения",
                         userEmail: ""),
        ].shuffled()
    }
}
