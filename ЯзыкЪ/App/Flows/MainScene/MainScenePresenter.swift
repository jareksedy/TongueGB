//
//  MainScenePresenter.swift
//  ЯзыкЪ
//
//  Created by Ярослав on 01.05.2022.
//

import UIKit
import Firebase

// MARK: - Presenter
final class MainScenePresenter {
    weak var viewDelegate: MainSceneViewDelegate?
    weak var api: FirebaseAPI?
    
    // MARK: - Public methods
    func storeAddedWordCardToFirebase(_ controller: UIViewController, word: String, translation: String, transcription: String, category: String) {
        let api = FirebaseAPI()
        guard let userEmail = api.authService.currentUser?.email else { return }
        let card = CardFirebase(word: word, translation: translation, transcription: transcription, category: category, userEmail: userEmail)
        api.storeWordCard(card)
    }
    
    func fetchCardsFromFirebase(_ controller: UIViewController, completion: @escaping ([CardFirebase]?) -> Void) {
        let api = FirebaseAPI()
        var cards: [CardFirebase] = []
        api.fetchWordCardsArray { cardsFirebase in
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
