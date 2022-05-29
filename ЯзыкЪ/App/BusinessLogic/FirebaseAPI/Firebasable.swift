//
//  Firebasable.swift
//  ЯзыкЪ
//
//  Created by Denis Kazarin on 04.05.2022.
//

import Foundation

protocol Firebasable {
    //MARK: - User operations
    func createUser(_ user: UserFirebase, completion: @escaping (Error?) -> Void)
    func signInUser(_ user: UserFirebase, completion: @escaping (Error?) -> Void)
    
    //MARK: - Storing
    func storeWordCard(_ card: CardFirebase)
    func storeCategory(_ category: CategoryFirebase)
    
    //MARK: - Fetching
    func fetchAllCards(completion: @escaping ([CardFirebase]?) -> Void)
    func fetchWordCardsByCategory(_ category: String, completion: @escaping ([CardFirebase]?) -> Void)
    func fetchCategoriesList(completion: @escaping([CategoryFirebase]?) -> Void)
    
    //MARK: - Deleting
    func deleteWordCard(_ word: String, _ userEmail: String)
}
