//
//  Firebasable.swift
//  ЯзыкЪ
//
//  Created by Denis Kazarin on 04.05.2022.
//

import Foundation

protocol Firebasable {
    
    //MARK: - UserData funcs
    func authUser(_ user: UserFirebase)
    func fetchUser(_ userEmail: String) -> UserFirebase?
    
    //MARK: - Store Funcs
    //MARK: -- Store word card
    func storeWordCard(_ card: CardFirebase)
    //MARK: -- Store category
    func storeCategory(_ category: CategoryFirebase)
    
    //MARK: - Fetch Funcs
    //MARK: -- Fetch word cards
    func fetchWordCard(_ keyWord: String) -> CardFirebase?
    func fetchWordCardsByCategory(_ category: CategoryFirebase) -> [CardFirebase]?
    //MARK: -- Fetch category
    func fetchCategory(_ category: String) -> CategoryFirebase?
    func fetchCategoryList(_ userEmail: String) -> [CategoryFirebase]?
}

