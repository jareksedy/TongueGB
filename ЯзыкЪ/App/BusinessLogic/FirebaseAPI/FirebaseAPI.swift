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
    
    // MARK: - Properties
    let authService = Auth.auth()
    let databaseService = Database.database()
    var state: AuthStateDidChangeListenerHandle?
    

    // MARK: --  UserData funcs
    func signInUser(_ user: UserFirebase, completion: @escaping () -> Void ) {
         authService.signIn(withEmail: user.userEmail, password: user.userId) { auth, error in
             guard error == nil else {
                 print("Error: \(String(describing: error?.localizedDescription))")
                 return
             }
             
             completion()
         }
     }
    
    // MARK: -- Store Funcs
    
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
    
    // MARK: -- Fetch funcs
    func fetchAllCards(completion: @escaping ([CardFirebase]?) -> Void) {
        guard let currentUserEmail = authService.currentUser?.email else { return }
        
        var cards: [CardFirebase] = []
        
        let ref = databaseService.reference(withPath: currentUserEmail.modifyEmailAddress())
            .child("cards")
        
        ref.getData { error, snapshot in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            snapshot.children.forEach { child in
                guard let childSnapshot = child as? DataSnapshot, let card = CardFirebase(snapshot: childSnapshot) else { return }
                cards.append(card)
            }
            
            completion(cards.isEmpty ? nil : cards)
        }
    }
    
    func fetchWordCardsByCategory(_ category: String, completion: @escaping ([CardFirebase]?) -> Void) {
        guard let currentUserEmail = authService.currentUser?.email else { return }
        
        var cards: [CardFirebase] = []
        
        let ref = databaseService
            .reference(withPath: currentUserEmail.modifyEmailAddress())
            .child("cards")
            .queryOrdered(byChild: "category")
            .queryEqual(toValue: category)
        
        ref.observe(.value, with: { (snapshot) in
            snapshot.children.forEach { child in
                guard let childSnapshot = child as? DataSnapshot,
                      let card = CardFirebase(snapshot: childSnapshot)
                else { return }
                
                cards.append(card)
            }
            completion(cards.isEmpty ? nil : cards)
        })
    }
    
    func fetchCategoriesList(completion: @escaping([CategoryFirebase]?) -> Void) {
        guard let currentUserEmail = authService.currentUser?.email else { return }
        
        var categories: [CategoryFirebase] = []
        
        let ref = databaseService
            .reference(withPath: currentUserEmail.modifyEmailAddress())
            .child("categories")
        
        ref.getData { error, snapshot in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            snapshot.children.forEach { child in
                guard let childSnapshot = child as? DataSnapshot,
                      let category = CategoryFirebase(snapshot: childSnapshot)
                else { return }
                
                categories.append(category)
            }
            completion(categories.isEmpty ? nil : categories)
        }
    }
}
