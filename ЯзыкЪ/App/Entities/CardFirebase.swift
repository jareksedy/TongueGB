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
    let transcription: String?
    let category: String
    let userEmail: String
    var timeStamp = Date().timeIntervalSince1970
    let ref: DatabaseReference?
    
    init(word: String, translation: String, transcription: String?, category: String, userEmail: String) {
        self.word = word
        self.translation = translation
        self.transcription = transcription
        self.category = category
        self.userEmail = userEmail
        self.ref = nil
    }
    
    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: Any],
            let word = value["word"] as? String,
            let translation = value["translation"] as? String,
            let transcription = value["transcription"] as? String,
            let category = value["category"] as? String,
            let userEmail = value["user_email"] as? String,
            let timeStamp = value["time_stamp"] as? Double else {
            return nil
        }
        self.word = word
        self.translation = translation
        self.transcription = transcription
        self.category = category
        self.userEmail = userEmail
        self.timeStamp = timeStamp
        self.ref = snapshot.ref
    }
    
    func toAnyObject() -> [String: Any] {
        return [
            "word": word as Any,
            "translation": translation as Any,
            "transcription": transcription as Any,
            "category": category as Any,
            "user_email": userEmail.modifyEmailAddress() as Any,
            "time_stamp": timeStamp as Any
        ] as [String: Any]
    }
}
