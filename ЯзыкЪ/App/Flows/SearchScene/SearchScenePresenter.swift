//
//  SearchScenePresenter.swift
//  ЯзыкЪ
//
//  Created by Ярослав on 01.05.2022.
//

import UIKit

// MARK: - Presenter
final class SearchScenePresenter {
    weak var viewDelegate: SearchSceneViewDelegate?
    
    // MARK: - Services
    private let firebaseAPI: FirebaseAPI
    
    // MARK: - Initializers
    init(_ firebaseAPI: FirebaseAPI) {
        self.firebaseAPI = firebaseAPI
    }
    

    
    // MARK: - Public methods
    func fetchCardsFromFirebase(completion: @escaping ([CardFirebase]?, [CategoryWithCount]?) -> Void) {
        var cards: [CardFirebase] = []
        var counts: [String: Int] = [:]
        var categories: [CategoryWithCount] = []
        
        firebaseAPI.fetchAllCards { cardsFirebase in
            guard let cardsFirebase = cardsFirebase else { return }
            cards = cardsFirebase
            counts = cardsFirebase.reduce(into: [:]) { counts, card in counts[card.category, default: 0] += 1 }
            
            counts.forEach { cardCount in
                categories.append(CategoryWithCount(name: cardCount.key, count: cardCount.value))
            }
            
            if cards.isEmpty { completion(nil, nil) } else { completion(cards, categories.sorted(by: {$0.name < $1.name})) }
        }
    }
    
    func fetchCategoriesFromFirebase(completion: @escaping ([CategoryFirebase]?) -> Void) {
        var categories: [CategoryFirebase] = []
        firebaseAPI.fetchCategoriesList { categoriesFirebase in
            guard let categoriesFirebase = categoriesFirebase else { return }
            categories = categoriesFirebase
            
            if categories.isEmpty {
                completion(nil)
            } else {
                completion(categories)
            }
        }
    }
}
