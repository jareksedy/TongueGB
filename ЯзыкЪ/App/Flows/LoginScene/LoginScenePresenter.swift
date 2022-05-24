//
//  LoginScenePresenter.swift
//  ЯзыкЪ
//
//  Created by Ярослав on 30.04.2022.
//

import UIKit
import AVFoundation

// MARK: - Presenter
final class LoginScenePresenter {
    weak var viewDelegate: LoginSceneViewDelegate?
    weak var api: FirebaseAPI?
    
    // MARK: - Public methods
    func authUserFromFirebase(_ user: UserFirebase, completion: () -> Void ) {
        
    }
}
