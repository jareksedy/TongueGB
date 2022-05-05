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
        //TODO: Need code
        authService.createUser(withEmail: user.email, password: String(user.id)) { [weak self] _, error in
            guard error == nil else {
                self?.showAlert("Ошибка регистрации", "Ошибка записи нового пользователя в базу данных: \(error?.localizedDescription ?? "неизвестная ошибка")")
                return
            }
            self?.authService.signIn(withEmail: user.email, password: String(user.id)) { [weak self] _, error in
                guard error == nil else {
                    self?.showAlert("Ошибка авторизации", "Ошибка авторизации пользователя в базе данных: \(error?.localizedDescription ?? "неизвестная ошибка")")
                    return
                }
                //TODO: Навигация на следующий экран + добавление listener
            }
        }
    }
    
    func authUser(_ user: User) {
        Auth.auth().signIn(withEmail: user.email, password: String(user.id)) { [weak self] _, error in
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
    
    func storeWordCard(_ card: Card, _ userEmail: String) {
        //TODO: Need code
    }
    
    func fetchWordCard(_ keyWord: String, _ userEmail: String) -> Card? {
        //TODO: Need code
        return nil //TODO: Correct return
    }
    
    func fetchWordCardsByCategory(_ category: CardsCategory, _ userEmail: String) -> [Card]? {
        //TODO: Need code
        return nil //TODO: Correct return
    }
    
    func storeCategory(_ category: CardsCategory) {
        //TODO: Need code
    }
    
    func fetchCategoryList() -> [CardsCategory]? {
        //TODO: Need code
        return nil //TODO: Correct return
    }
    
}
