//
//  FirebaseAPI.swift
//  ЯзыкЪ
//
//  Created by Denis Kazarin on 04.05.2022.
//


import Foundation
import Firebase
import UIKit


class FirebaseAPI: Firebasable {
    
    //MARK: - Properties
    let authService = Auth.auth()
    let databaseService = Database.database()
    var state: AuthStateDidChangeListenerHandle?
    
    //MARK: - Private funcs
    
    
    
   
    
    //MARK: - Protocol funcs
    //MARK: --  UserData funcs
    func signInUser(_ user: UserFirebase, completion: @escaping () -> Void ) {
         authService.signIn(withEmail: user.userEmail, password: user.userId) { auth, error in
             guard error == nil else {
                 print("Error: \(String(describing: error?.localizedDescription))")
                 return
             }
             completion()
         }
     }
    
    //MARK: -- Store Funcs
    
    func storeWordCard(_ card: CardFirebase) {
        guard let signedUserEmail = authService.currentUser?.email, signedUserEmail == card.userEmail else { return }
        let ref = self.databaseService.reference(withPath: signedUserEmail.modifyEmailAddress()).child("cards").child(card.word)
        let value = card.toAnyObject()
        ref.setValue(value)
        self.storeCategory(CategoryFirebase(categoryName: card.category))
        
    }
    
    func storeCategory(_ category: CategoryFirebase) {
        guard let signedUserEmail = authService.currentUser?.email else { return }
        let ref = self.databaseService.reference(withPath: signedUserEmail.modifyEmailAddress()).child("categories").child(category.categoryName)
        let value = category.toAnyObject()
        ref.setValue(value)
        
    }
    
    //MARK: -- Fetch funcs
    
    func fetchWordCard(_ keyWord: String, completion: @escaping (CardFirebase?) -> Void) {
        guard let currentUserEmail = authService.currentUser?.email else { return }
        let ref = databaseService.reference(withPath: currentUserEmail.modifyEmailAddress()).child("cards").child(keyWord)
        ref.getData { error, snapshot in
            guard error == nil else {
                print("Error: \(String(describing: error?.localizedDescription))")
                return }
            let card = CardFirebase(snapshot: snapshot)
            if card == nil {
                completion(nil)
            } else {
                completion(card)}
        }
    }
    
    func fetchWordCardsArray(completion: @escaping ([CardFirebase]?) -> Void) {
        var cards: [CardFirebase] = []
        guard let currentUserEmail = authService.currentUser?.email else { return }
        let ref = databaseService.reference(withPath: currentUserEmail.modifyEmailAddress()).child("cards")
        ref.getData { error, snapshot in
            guard error == nil else {
                print("Error: \(String(describing: error?.localizedDescription))")
                return
            }
            for child in snapshot.children {
                guard let childSnapshot = child as? DataSnapshot, let card = CardFirebase(snapshot: childSnapshot) else { return}
                cards.append(card)
            }
            if cards.isEmpty {
                completion(nil)
            } else {
                completion(cards.reversed())
            }
        }
    }
    
    func fetchWordCardsByCategory(_ category: String, completion: @escaping ([CardFirebase]?) -> Void) {
        var cards: [CardFirebase] = []
        guard let currentUserEmail = authService.currentUser?.email else { return }
        let ref = databaseService.reference(withPath: currentUserEmail.modifyEmailAddress()).child("cards")
        ref.getData { error, snapshot in
            guard error == nil else {
                print("Error: \(String(describing: error?.localizedDescription))")
                return
            }
            for child in snapshot.children {
                guard let childSnapshot = child as? DataSnapshot, let card = CardFirebase(snapshot: childSnapshot) else { return }
                if card.category == category {
                    cards.append(card)
                }
            }
            if cards.isEmpty {
                completion(nil)
            } else {
                completion(cards)
            }
        }
    }
    
    func fetchCategory(_ category: String, completion: @escaping (CategoryFirebase?) -> Void ) {
        guard let currentUserEmail = authService.currentUser?.email else { return }
        let ref = databaseService.reference(withPath: currentUserEmail.modifyEmailAddress()).child("categories").child(category)
        ref.getData { error, snapshot in
            guard error == nil else {
                print("Error: \(String(describing: error?.localizedDescription))")
                return
            }
            let category = CategoryFirebase(snapshot: snapshot)
            if category == nil {
                completion(nil)
            } else {
                completion(category)
            }
        }
        
    }
    
    func fetchCategoryList(completion: @escaping([CategoryFirebase]?) -> Void) {
        var categories: [CategoryFirebase] = []
        guard let currentUserEmail = authService.currentUser?.email else { return }
        let ref = databaseService.reference(withPath: currentUserEmail.modifyEmailAddress()).child("categories")
        ref.getData { error, snapshot in
            guard error == nil else {
                print("Error: \(String(describing: error?.localizedDescription))")
                return
            }
            for child in snapshot.children {
                guard let childSnapshot = child as? DataSnapshot, let category = CategoryFirebase(snapshot: childSnapshot) else { return}
                categories.append(category)
            }
            if categories.isEmpty {
                completion(nil)
            } else {
                completion(categories)
            }
        }
    }
}
