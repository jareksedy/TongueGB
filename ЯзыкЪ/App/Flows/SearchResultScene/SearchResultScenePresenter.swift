//
//  SearchResultScenePresenter.swift
//  ЯзыкЪ
//
//  Created by Ярослав on 17.05.2022.
//

import UIKit

// MARK: - Presenter
final class SearchResultScenePresenter {
    weak var viewDelegate: SearchResultSceneViewDelegate?
    
    // MARK: - Services
    private let firebaseAPI: FirebaseAPI
    
    // MARK: - Initializers
    init(_ firebaseAPI: FirebaseAPI) {
        self.firebaseAPI = firebaseAPI
    }
    
    // MARK: - Public methods
    
    func fetchCardsForCategoryFromFirebase(_ controller: UIViewController, _ categoryName: String?, completion: @escaping ([CardFirebase]?) -> Void) {
        var cards: [CardFirebase] = []
        guard let categoryName = categoryName else { return }
        firebaseAPI.fetchWordCardsByCategory(categoryName) { cardsFirebase in
            guard let cardsFirebase = cardsFirebase else { return }
            cards = cardsFirebase
            
            if cards.isEmpty {
                completion(nil)
            } else {
                completion(cards)
            }
        }
    }
}
