//
//  ProfileScenePresenter.swift
//  ЯзыкЪ
//
//  Created by Ярослав on 01.05.2022.
//

import UIKit
import KeychainSwift

// MARK: - Presenter
final class ProfileScenePresenter {
    weak var viewDelegate: ProfileSceneViewDelegate?
    private let firebaseAPI: FirebaseAPI
    private let keychain = KeychainSwift()
    
    
    // MARK: - Initializers
    init(_ firebaseAPI: FirebaseAPI) {
        self.firebaseAPI = firebaseAPI
    }
        
    // MARK: - Public methods
    func logOut() {
        AppDefaults.shared.userSignedIn = false
        viewDelegate?.proceedToLoginScreen()
    }
    
    func fetchProfileInfo(completion: @escaping (ProfileFirebase?) -> Void) {
        var profile = ProfileFirebase(cardsCount: 0, categoriesCount: 0)
        var categories: [CategoryWithCount] = []
        
        firebaseAPI.fetchAllCards { cardsFirebase in
            guard let cardsFirebase = cardsFirebase else {
                completion(nil)
                return
            }
            
            categories = cardsFirebase.reduce(into: [:]) { counts, card in counts[card.category, default: 0] += 1 }.map { CategoryWithCount(name: $0.key, count: $0.value) }
            profile.categoriesCount = categories.count
            profile.cardsCount = cardsFirebase.count
            
            completion(profile)
        }
    }
}
