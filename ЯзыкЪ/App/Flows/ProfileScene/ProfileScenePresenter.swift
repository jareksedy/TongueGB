//
//  ProfileScenePresenter.swift
//  ЯзыкЪ
//
//  Created by Ярослав on 01.05.2022.
//

import UIKit

// MARK: - Presenter
final class ProfileScenePresenter {
    weak var viewDelegate: ProfileSceneViewDelegate?
    private let firebaseAPI: FirebaseAPI
    
    // MARK: - Initializers
    init(_ firebaseAPI: FirebaseAPI) {
        self.firebaseAPI = firebaseAPI
    }
        
    // MARK: - Public methods
    func logOut() {
        AppDefaults.shared.userSignedIn = false
        viewDelegate?.proceedToLoginScene()
    }
    
    func fetchProfileInfo(completion: @escaping (ProfileFirebase?) -> Void) {
        var profile = ProfileFirebase(user: "", categoriesCount: 0, cardsCount: 0)
        var counts: [String: Int] = [:]
        var categories: [CategoryWithCount] = []
        
        firebaseAPI.fetchAllCards { cardsFirebase in
            guard let cardsFirebase = cardsFirebase, let currentUserEmail = self.firebaseAPI.authService.currentUser?.email else { return }
            profile.user = currentUserEmail
            counts = cardsFirebase.reduce(into: [:]) { counts, card in counts[card.category, default: 0] += 1 }
            
            counts.forEach { cardCount in
                categories.append(CategoryWithCount(name: cardCount.key, count: cardCount.value))
            }
            
            profile.categoriesCount = categories.count
            profile.cardsCount = cardsFirebase.count
            
            completion(profile == ProfileFirebase(user: "", categoriesCount: 0, cardsCount: 0) ? nil : profile)
        }
    }
}
