//
//  CardsCategoryFirebase.swift
//  ЯзыкЪ
//
//  Created by Denis Kazarin on 04.05.2022.
//

import Foundation
import Firebase

class CardsCategoryFirebase {
    let categoryKey: String
    let categoryColor: String?
    let categoryImage: String?
    let userEmail: String
    let ref: DatabaseReference?
    
    init(categoryKey: String, categoryColor: String?, categoryImage: String?, userEmail: String) {
        self.categoryKey = categoryKey
        self.categoryColor = categoryColor
        self.categoryImage = categoryImage
        self.userEmail = userEmail
        self.ref = nil
    }
    
    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: Any],
            let categoryKey = value["category_key"] as? String,
            let categoryColor = value["category_color"] as? String,
            let categoryImage = value["category_image"] as? String,
            let userEmail = value["user_email"] as? String
        else {
            return nil
        }
        
        self.categoryKey = categoryKey
        self.categoryColor = categoryColor
        self.categoryImage = categoryImage
        self.userEmail = userEmail
        self.ref = snapshot.ref
    }
    
    func toAnyObject() -> [String: Any] {
        return [
            "category_key": categoryKey as Any,
            "category_color": categoryColor as Any,
            "category_image": categoryImage as Any,
            "user_email": userEmail.replacingOccurrences(of: "[@.]", with: "_") as Any
        ] as [String: Any]
    }
}
