//
//  FirebaseAPI.swift
//  ЯзыкЪ
//
//  Created by Denis Kazarin on 04.05.2022.
//

import Foundation

class FirebaseAPI: Firebasable {
    func authFirebase(_ user: User) {
        //TODO: Need code
    }
    
    func storeUser(_ user: User) {
        //TODO: Need code
    }
    
    func fetchUserByEmail(_ userEmail: String) -> User? {
        //TODO: Need code
        return nil //TODO: Correct return
    }
    
    func storeWordCard(_ card: Card) {
        //TODO: Need code
    }
    
    func fetchWordCard(_ keyWord: String, _ userEmail: String) -> Card? {
        //TODO: Need code
        return nil //TODO: Correct return
    }
    
    func fetchWordCardsByCategory(_ category: CardsCategory, _ userEmail: String) -> [Card]? {
        //TODO: Need code
        return nil //TODO: Correct return
    }
    
    func storeCategory(_ category: CardsCategory) {
        //TODO: Need code
    }
    
    func fetchCategoryList() -> [CardsCategory]? {
        //TODO: Need code
        return nil //TODO: Correct return
    }
    
}
