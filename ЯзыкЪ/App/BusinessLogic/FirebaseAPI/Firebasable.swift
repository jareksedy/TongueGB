//
//  Firebasable.swift
//  ЯзыкЪ
//
//  Created by Denis Kazarin on 04.05.2022.
//

import Foundation

protocol Firebasable {
    
    //MARK: - UserData funcs
    func signInUser(_ user: UserFirebase, completion: @escaping () -> Void )
    
    //MARK: - Store Funcs
    //MARK: -- Store word card
    func storeWordCard(_ card: CardFirebase)
    //MARK: -- Store category
    func storeCategory(_ category: CategoryFirebase)
    
    //MARK: - Fetch Funcs
    //MARK: -- Fetch word cards
    func fetchWordCardsArray(completion: @escaping ([CardFirebase]?) -> Void)
    func fetchWordCardsByCategory(_ category: String, completion: @escaping ([CardFirebase]?) -> Void) 
    //MARK: -- Fetch category
    func fetchCategoriesList(completion: @escaping([CategoryFirebase]?) -> Void)
}

