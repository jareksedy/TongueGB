//
//  LoginScenePresenter.swift
//  ЯзыкЪ
//
//  Created by Ярослав on 30.04.2022.
//

import UIKit

// MARK: - Presenter
final class LoginScenePresenter {
    weak var viewDelegate: LoginSceneViewDelegate?
    let firebaseAPI: FirebaseAPI
    
    init(_ firebaseAPI: FirebaseAPI) {
        self.firebaseAPI = firebaseAPI
    }
    
    // MARK: - Public methods
    func createUserForFirebase(_ user: UserFirebase) {
        firebaseAPI.createUser(user, completion: { error in
            if let error = error {
                self.viewDelegate?.displayError(error)
            } else {
                self.viewDelegate?.proceedToMainScene()
            }
        })
    }
    
    func authUserForFirebase(_ user: UserFirebase) {
        firebaseAPI.signInUser(user, completion: { error in
            if let error = error {
                self.viewDelegate?.displayError(error)
            } else {
                self.viewDelegate?.proceedToMainScene()
            }
        })
    }
}
