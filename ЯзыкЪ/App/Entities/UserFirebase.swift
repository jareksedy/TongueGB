//
//  UserFirebase.swift
//  ЯзыкЪ
//
//  Created by Denis Kazarin on 04.05.2022.
//

import Foundation
import Firebase

class UserFirebase {
    let userEmail: String
    let userId: Int
    let ref: DatabaseReference?
    
    init(userEmail: String, userId: Int) {
        self.userEmail = userEmail
        self.userId = userId
        self.ref = nil
    }
    
    init?(snapshot: DataSnapshot) {
        guard let value = snapshot.value as? [String: Any],
              let email = value["user_email"] as? String,
              let id = value["user_id"] as? Int else {
            return nil
        }
        
        self.userEmail = email
        self.userId = id
        self.ref = snapshot.ref
    }
    
    func toAnyObject() -> [String: Any] {
        return [
            "user_email": userEmail,
            "user_id": userId
        ] as [String: Any]
    }
}
