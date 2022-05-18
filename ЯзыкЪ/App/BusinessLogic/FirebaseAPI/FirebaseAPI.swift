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
    var token: AuthStateDidChangeListenerHandle? = nil
    
    init(controller: UIViewController) {
        self.controller = controller
    }
    
    //MARK: - Private funcs
    private func showAlert(_ title: String, _ message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Хорошо", style: .cancel, handler: nil)
        alert.addAction(okAction)
        self.controller.present(alert, animated: true, completion: nil)
    }
    
    //MARK: - Service funcs
    func addListener() {
        authService.addStateDidChangeListener { auth, user in
            guard user != nil else { return }
        }
    }
    
    //MARK: - Protocol funcs
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
                //TODO: Навигация на следующий экран + добавление listener
            }
        }
    }
    
    func authUser(_ user: User) {
        Auth.auth().signIn(withEmail: user.userEmail, password: String(user.userId)) { [weak self] _, error in
            guard error == nil else {
                self?.showAlert("Ошибка авторизации", "Ошибка авторизации пользователя в базе данных: \(error?.localizedDescription ?? "неизвестная ошибка")")
                return
            }
            //TODO: Навигация на следующий экран + добавление listener
        }
    }
    
    func fetchUserByEmail(_ userEmail: String) -> User? {
        //TODO: Need code
        
        return nil //TODO: Correct return
    }
    
    func storeWordCard(_ card: Card) {
        let cardModel = CardFirebase(word: card.word, translation: card.translation, description: card.description, category: card.category.categoryKey, userEmail: card.userEmail)
        let cardRef = Database.database().reference(withPath: cardModel.userEmail.modifyEmailAddress()).child("cards").child(cardModel.word)
        let value = cardModel.toAnyObject()
        cardRef.setValue(value)
        storeCategory(CardsCategory(categoryKey: card.category.categoryKey, categoryColor: card.category.categoryColor, categoryImage: card.category.categoryImage, userEmail: card.category.userEmail))
    }
    
    func fetchWordCard(_ keyWord: String, _ userEmail: String) -> Card? {
        let cardRef = Database.database().reference(withPath: userEmail.modifyEmailAddress()).child("cards").child(keyWord)
        var card: Card? = nil
        cardRef.getData { error, dataSnapshot in
            guard error == nil else {
                print("Error: \(String(describing: error?.localizedDescription))")
                return
            }
            guard let cardFirebase = CardFirebase(snapshot: dataSnapshot) else { return }
            //guard let categoryFirebase = self.fetchCategory(cardFirebase.category, userEmail) else { return }
            //TODO: - Дополнить получение цвета и картинки из категории (пока nil стоит)
            print(cardFirebase)
            card = Card(word: cardFirebase.word, translation: cardFirebase.translation, description: cardFirebase.description, category: CardsCategory(categoryKey: cardFirebase.category, categoryColor: nil, categoryImage: nil, userEmail: cardFirebase.userEmail), userEmail: cardFirebase.userEmail)
        }
        return card
    }
    
    func fetchWordCardsByCategory(_ category: CardsCategory, _ userEmail: String) -> [Card]? {
        //TODO: Need code. Через for в массиве карточек)))
        return nil //TODO: Correct return
    }
    
    func storeCategory(_ category: CardsCategory) {
        let categoryModel = CardsCategoryFirebase(categoryKey: category.categoryKey, categoryColor: category.categoryColor, categoryImage: category.categoryImage, userEmail: category.userEmail)
        let categoryRef = Database.database().reference(withPath: categoryModel.userEmail.modifyEmailAddress()).child("categories").child(category.categoryKey)
        let value = categoryModel.toAnyObject()
        categoryRef.setValue(value)
    }
    
    func fetchCategory(_ categoryKey: String, _ userEmail: String) -> CardsCategory? {
        let categoryRef = Database.database().reference(withPath: userEmail.modifyEmailAddress()).child("categories").child(categoryKey)
        var category: CardsCategory? = nil
        categoryRef.getData { error, dataSnapshot in
            guard error == nil else {
                print("Error: \(String(describing: error?.localizedDescription))")
                return
            }
            guard let categoryFirebase = CardsCategoryFirebase(snapshot: dataSnapshot) else { return }
            category = CardsCategory(categoryKey: categoryFirebase.categoryKey, categoryColor: categoryFirebase.categoryColor, categoryImage: categoryFirebase.categoryImage, userEmail: categoryFirebase.userEmail)
        }
        return category
    }
    
    func fetchCategoryList(_ userEmail: String) -> [CardsCategory]? {
        let categoriesRef = Database.database().reference(withPath: userEmail.modifyEmailAddress()).child("categories")
        var categories: [CardsCategory]? = nil
        categoriesRef.getData { error, dataSnapshot in
            guard error == nil else {
                print("Error: \(String(describing: error?.localizedDescription))")
                return
            }
            //TODO: Переделать метод. Он неправильный. Надо через for по всему массиву.
            guard let categoriesFirebase = dataSnapshot.value as? [CardsCategoryFirebase] else { return }
            for category in categoriesFirebase {
                let cardCategory = CardsCategory(categoryKey: category.categoryKey, categoryColor: category.categoryColor, categoryImage: category.categoryImage, userEmail: category.userEmail)
                categories?.append(cardCategory)
            }
        }
        return categories
    }
}
