//
//  CardFirebase.swift
//  ЯзыкЪ
//
//  Created by Denis Kazarin on 04.05.2022.
//

import Foundation
import Firebase

class CardFirebase {
    let word: String
    let translation: String
    let description: String?
    let category: CardsCategory
    let userEmail: String
    let ref: DatabaseReference?
    
    init(word: String, translation: String, category: CardsCategory, userEmail: String) {
        self.word = word
        self.translation = translation
        self.description = nil
        self.category = CardsCategory(categoryKey: category.categoryKey, categoryColor: category.categoryColor, categoryImage: category.categoryImage)
        self.userEmail = userEmail
        self.ref = nil
    }
    
    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: Any],
            let word = value["word"] as? String,
            let translation = value["translation"] as? String,
            let description = value["description"] as? String,
            let category = value["category"] as? CardsCategory,
            let userEmail = value["user_email"] as? String else {
            return nil
        }
        self.word = word
        self.translation = translation
        self.description = description
        self.category = category
        self.userEmail = userEmail
        self.ref = snapshot.ref
    }
    
    func toAnyObject() -> [String: Any] {
        return [
            "word": word,
            "translation": translation,
            "description": description as Any,
            "category": CardsCategory.self,
            "user_email": userEmail
        ]
    }
}
