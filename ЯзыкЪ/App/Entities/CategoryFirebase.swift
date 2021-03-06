//
//  CategoryFirebase.swift
//  ЯзыкЪ
//
//  Created by Denis Kazarin on 04.05.2022.
//

import Foundation
import Firebase

class CategoryFirebase {
    let categoryName: String
    let ref: DatabaseReference?
    
    init(categoryName: String) {
        self.categoryName = categoryName
        self.ref = nil
    }
    
    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: Any],
            let categoryName = value["category_name"] as? String
        else {
            return nil
        }
        self.categoryName = categoryName
        self.ref = snapshot.ref
    }
    
    func toAnyObject() -> [String: Any] {
        return [
            "category_name": categoryName as Any
        ] as [String: Any]
    }
}

struct CategoryWithCount {
    var name: String
    var count: Int
}
