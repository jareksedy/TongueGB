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
    
    let controller: UIViewController
    
    init(controller: UIViewController) {
        self.controller = controller
    }
    
    var actionCodeSettings = ActionCodeSettings()
    
    private func configureActionCodeSettings(_ actionCodeSettings: ActionCodeSettings) -> ActionCodeSettings {
        actionCodeSettings.url = URL(string: "tonguegb-16695.firebaseapp.com")
        actionCodeSettings.handleCodeInApp = true
        actionCodeSettings.setIOSBundleID(Bundle.main.bundleIdentifier!)
        return actionCodeSettings
    }
    
    
    func authFirebase(_ user: User) {
       
        actionCodeSettings = configureActionCodeSettings(actionCodeSettings)
        Auth.auth().sendSignInLink(toEmail: user.email, actionCodeSettings: actionCodeSettings) { error in
            guard error == nil else {
                // TODO: Добавить сообщение для пользователя об ошибке
                return
            }
               // The link was successfully sent. Inform the user.
               // Save the email locally so you don't need to ask the user for it again
               // if they open the link on the same device.
            
                // TODO: Добавить сохранение пользователя в KeyChain (UserDefaults не подойдет, так как не обеспечивает защиту данных.
            UserDefaults.standard.set(user.email, forKey: "Email")
                // TODO: Добавить сообщение для пользователя.
            
        }
    }
    
    func storeUser(_ user: User) {
        //TODO: Need code
        Auth.auth().createUser(withEmail: user.email, password: String(user.id))
    }
    
    func fetchUserByEmail(_ userEmail: String) -> User? {
        //TODO: Need code
        return nil //TODO: Correct return
    }
    
    func storeWordCard(_ card: Card) {
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
