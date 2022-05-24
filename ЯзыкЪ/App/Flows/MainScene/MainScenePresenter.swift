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
        let api = FirebaseAPI(controller: controller)
        guard let userEmail = api.authService.currentUser?.email else { return }
        let card = CardFirebase(word: word, translation: translation, transcription: transcription, category: category, userEmail: userEmail)
        api.storeWordCard(card)
    }
}
