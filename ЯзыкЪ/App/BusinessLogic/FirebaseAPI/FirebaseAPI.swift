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
    let controller: UIViewController
    let authService = Auth.auth()
    let databaseService = Database.database()
    var firebaseUser: FirebaseAuth.User?
    
    init(_ controller: UIViewController) {
        self.controller = controller
    }
    
    //MARK: - Private funcs
    private func showAlert(_ title: String, _ message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Хорошо", style: .cancel, handler: nil)
        alert.addAction(okAction)
        self.controller.present(alert, animated: true, completion: nil)
    }
    
    private func signInUser(_ user: User) {
        authService.signIn(withEmail: user.userEmail, password: String(user.userId)) { [weak self] _, error in
            guard error == nil else {
                self?.showAlert("Ошибка авторизации", "Ошибка авторизации пользователя в базе данных: \(error?.localizedDescription ?? "неизвестная ошибка")")
                return
            }
        }
        firebaseUser = authService.currentUser
    }
    
    //MARK: - State func
    func authState() {
        authService.addStateDidChangeListener { auth, user in
            guard user != nil else {
               // print("No user after state check")
                return
            }
            print("Have user: \(String(describing: user?.email))")
            self.firebaseUser = user
           // print("FirebaseUser: \(String(describing: self.firebaseUser))")
        }
    }
    
    //MARK: - Protocol funcs
    
    //MARK: -- SignIn, Auth and Store funcs
    
    func createUser(_ user: User) {
        authService.createUser(withEmail: user.userEmail, password: String(user.userId)) { [weak self] _, error in
            guard error == nil else {
                self?.showAlert("Ошибка регистрации", "Ошибка записи нового пользователя в базу данных: \(error?.localizedDescription ?? "неизвестная ошибка")")
                return
            }
            self?.authService.signIn(withEmail: user.userEmail, password: String(user.userId)) { [weak self] _, error in
                guard error == nil else {
                    self?.showAlert("Ошибка авторизации", "Ошибка авторизации пользователя в базе данных: \(error?.localizedDescription ?? "неизвестная ошибка")")
                    return
                }
            }
        }
    }
    
    func authUser(_ user: User) {
        authState()
        print("SignedIn User: \(String(describing: authService.currentUser))")
        if authService.currentUser == nil {
            createUser(user)
        } else {
            signInUser(user)
        }
    }
    
    func storeWordCard(_ card: Card) {
        let cardModel = CardFirebase(word: card.word, translation: card.translation, description: card.description, category: card.category.categoryKey, userEmail: card.userEmail)
        let cardRef = databaseService.reference(withPath: cardModel.userEmail.modifyEmailAddress()).child("cards").child(cardModel.word)
        let value = cardModel.toAnyObject()
        cardRef.setValue(value)
        storeCategory(CardsCategory(categoryKey: card.category.categoryKey, categoryColor: card.category.categoryColor, categoryImage: card.category.categoryImage, userEmail: card.category.userEmail))
    }
    
    func storeCategory(_ category: CardsCategory) {
        let categoryModel = CardsCategoryFirebase(categoryKey: category.categoryKey, categoryColor: category.categoryColor, categoryImage: category.categoryImage, userEmail: category.userEmail)
        let categoryRef = databaseService.reference(withPath: categoryModel.userEmail.modifyEmailAddress()).child("categories").child(category.categoryKey)
        let value = categoryModel.toAnyObject()
        categoryRef.setValue(value)
    }
    
    //MARK: -- Fetch funcs
    
    func fetchUserByEmail(_ userEmail: String) -> User? {
        guard authService.currentUser != nil, authService.currentUser?.email != nil else { return nil}
        let user = User(userEmail: (authService.currentUser?.email!)!, userId: authService.currentUser!.uid)
        guard userEmail.lowercased() == user.userEmail else { return nil}
        return user
    }
    
    func fetchWordCard(_ keyWord: String, _ userEmail: String) -> Card? {
        print("Function Fetch Word Card Started Successfully")
        var fetchedCard: Card? = nil
        
        //TODO: Need code
        let ref = databaseService.reference().child("\(userEmail.modifyEmailAddress())/cards/\(keyWord)")
        print(ref)
        ref.getData { error, snapshot in
            guard error == nil else {
                print("Error: \(String(describing: error?.localizedDescription))")
                return
            }
            guard let firebaseCard = CardFirebase(snapshot: snapshot) else { return }
            print("FIREBASE CARD: \(firebaseCard)")
            fetchedCard = Card(word: firebaseCard.word, translation: firebaseCard.translation, description: firebaseCard.description, category: CardsCategory(categoryKey: firebaseCard.category, categoryColor: nil, categoryImage: nil, userEmail: firebaseCard.userEmail), userEmail: firebaseCard.userEmail)
        }
        
        print("FUNC FETCHED CARD: \(String(describing: fetchedCard))")
        return fetchedCard
    }
    
    func fetchWordCardsByCategory(_ category: CardsCategory, _ userEmail: String) -> [Card]? {
        //TODO: Need code. Через for в массиве карточек)))
        return nil //TODO: Correct return
    }
    
    func fetchCategory(_ categoryKey: String, _ userEmail: String) -> CardsCategory? {
        let category: CardsCategory? = nil
        //TODO: Need code
        return category
    }
    
    func fetchCategoryList(_ userEmail: String) -> [CardsCategory]? {
        let categories: [CardsCategory]? = nil
        // TODO: Need code
        return categories
    }
}
