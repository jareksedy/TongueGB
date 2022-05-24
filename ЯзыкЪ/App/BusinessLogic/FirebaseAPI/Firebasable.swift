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
    func fetchWordCard(_ keyWord: String, completion: @escaping (CardFirebase?) -> Void)
    func fetchWordCardsArray(completion: @escaping ([CardFirebase]?) -> Void)
    func fetchWordCardsByCategory(_ category: String, completion: @escaping ([CardFirebase]?) -> Void) 
    //MARK: -- Fetch category
    func fetchCategory(_ category: String, completion: @escaping (CategoryFirebase?) -> Void )
    func fetchCategoryList(completion: @escaping([CategoryFirebase]?) -> Void)
}

