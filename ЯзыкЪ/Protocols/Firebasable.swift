//
//  Firebasable.swift
//  ЯзыкЪ
//
//  Created by Denis Kazarin on 04.05.2022.
//

import Foundation

protocol Firebasable {
    
    //MARK: - UserData funcs
    
    func createUser(_ user: User)
    func authUser(_ user: User)
    func fetchUserByEmail(_ userEmail: String) -> User?
    
    //MARK: - WordCards funcs
    
    func storeWordCard(_ card: Card, _ userEmail: String)
    func fetchWordCard(_ keyWord: String, _ userEmail: String) -> Card?
    func fetchWordCardsByCategory(_ category: CardsCategory, _ userEmail: String) -> [Card]?
    
    //MARK: - CategoryLists funcs
    
    func storeCategory(_ category: CardsCategory)
    func fetchCategoryList() -> [CardsCategory]?
}
