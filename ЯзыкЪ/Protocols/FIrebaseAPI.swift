//
//  FIrebaseAPI.swift
//  ЯзыкЪ
//
//  Created by Denis Kazarin on 30.04.2022.
//

import Foundation

protocol FirebaseAPI {
    
    //MARK: - Auth FB funcs
    
    func authFirebase(_ user: User)
    
    //MARK: - UserData funcs
    
    func storeUser(_ user: User)
    func fetchUserByEmail(_ userEmail: String) -> User?
    
    //MARK: - WordCards funcs
    
    func storeWordCard(_ card: Card)
    func fetchWordCard(_ keyWord: String, _ userEmail: String) -> Card?
    func fetchWordCardsByCategory(_ category: Category, _ userEmail: String) -> [Card]?
    
    //MARK: - CategoryLists funcs
    
    func storeCategory(_ category: Category)
    func fetchCategoryList() -> [Category]
}
