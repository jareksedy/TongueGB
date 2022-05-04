//
//  UserFirebase.swift
//  ЯзыкЪ
//
//  Created by Denis Kazarin on 04.05.2022.
//

import Foundation
import Firebase

class UserFirebase {
    let email: String
    let id: Int
    let ref: DatabaseReference?
    
    init(email: String, id: Int) {
        self.email = email
        self.id = id
        self.ref = nil
    }
    
    init?(snapshot: DataSnapshot) {
        guard let value = snapshot.value as? [String: Any],
              let email = value["email"] as? String,
              let id = value["id"] as? Int else {
            return nil
        }
        
        self.ref = snapshot.ref
        self.email = email
        self.id = id
    }
    
    func toAnyObject() -> [String: Any] {
        return [
            "email": email,
            "id": id
        ]
    }
}
