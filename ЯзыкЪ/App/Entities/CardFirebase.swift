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
    let category: CategoryFirebase
    let userEmail: String
    let ref: DatabaseReference?
    
    init(word: String, translation: String, description: String?, category: CategoryFirebase, userEmail: String) {
        self.word = word
        self.translation = translation
        self.description = description
        self.category = category
        self.userEmail = userEmail
        self.ref = nil
    }
    
    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: Any],
            let word = value["word"] as? String,
            let translation = value["translation"] as? String,
            let description = value["description"] as? String,
            let category = value["category"] as? String,
            let userEmail = value["user_email"] as? String else {
            return nil
        }
        self.word = word
        self.translation = translation
        self.description = description
        self.category = CategoryFirebase(categoryName: category)
        self.userEmail = userEmail
        self.ref = snapshot.ref
    }
    
    func toAnyObject() -> [String: Any] {
        return [
            "word": word as Any,
            "translation": translation as Any,
            "description": description as Any,
            "category": category as Any,
            "user_email": userEmail.modifyEmailAddress() as Any
        ] as [String: Any]
    }
}
