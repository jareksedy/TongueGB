//
//  MainSceneViewController.swift
//  ЯзыкЪ
//
//  Created by Ярослав on 01.05.2022.
//

import UIKit

// MARK: - Protocol
protocol MainSceneViewDelegate: NSObjectProtocol {
    func addCard(word: String, translation: String, transcription: String, category: String)
    func scrollToStart(completion: ((Bool) -> Void)?)
}

// MARK: - View controller
class MainSceneViewController: UIViewController {
    let presenter = MainScenePresenter()
    
    // MARK: - Outlets
    @IBOutlet weak var cardsScrollOverlay: ScrollOverlayView!
    @IBOutlet var cardsScrollView: UIScrollView!
    @IBOutlet var cardsStackView: UIStackView!
    
    // MARK: - Constraint outlets
    @IBOutlet weak var cardsScrollViewLeading: NSLayoutConstraint!
    @IBOutlet weak var cardsScrollViewTrailing: NSLayoutConstraint!
    
    // MARK: - Services
    let mockCardsProvider = MockCardsProvider()
    
    // MARK: - Properties
    var cards: [CardFirebase]?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDelegate = self
        setupConstraints()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationOptions()
    }
    
    // MARK: - Private methods
    private func setupUI() {
        cardsScrollOverlay.referenceView = cardsScrollView
        
        cardsStackView.spacing = CGFloat.cardStackSpacing
        cardsStackView.layoutMargins.left = CGFloat.cardStackSpacing / 2
        cardsStackView.layoutMargins.right = CGFloat.cardStackSpacing / 2
        
        fetchCards()
        
        if let cards = cards, cards.count > 0 {
            for card in cards {
                let cardView = CardView()
                
                cardView.word = card.word
                cardView.translation = card.translation
                cardView.transcription = card.description
                cardView.category = card.category
                cardsStackView.addArrangedSubview(cardView)
            }
        } else {
            let emptyCardView = EmptyCardView()
            
            emptyCardView.viewDelegate = self
            cardsStackView.addArrangedSubview(emptyCardView)
        }
    }
    
    private func setupNavigationOptions() {
        self.navigationItem.title = "Мои карточки"
    }
    
    private func setupConstraints() {
        let gap = ((CGFloat.screenWidth - (CGFloat.screenWidth * CGFloat.cardScreenWidthMultiplier)) / 2) - (CGFloat.cardStackSpacing / 2)
        
        cardsScrollViewLeading.constant = gap
        cardsScrollViewTrailing.constant = gap
        
        self.view.layoutIfNeeded()
    }
    
    private func fetchCards() {
        cards = mockCardsProvider.createMockCards()
    }
}

// MARK: - Implementation
extension MainSceneViewController: MainSceneViewDelegate {
    func addCard(word: String, translation: String, transcription: String, category: String) {
        
        let cardView = CardView()
        cardView.word = word
        cardView.translation = translation
        cardView.transcription = transcription
        cardView.category = category
        cardView.isFront = true
        
        cardView.alpha = 0
        self.cardsStackView.insertArrangedSubview(cardView, at: 0)
        cardsScrollView.setContentOffset(.zero, animated: false)
        
        UIView.animate(withDuration: 0.25) {
            cardView.alpha = 1
            self.cardsStackView.layoutSubviews()
        }
    }
    
    func scrollToStart(completion: ((Bool) -> Void)?) {
        guard cardsScrollView.contentOffset.x > 0 else {
            completion?(true)
            return
        }
        let offsetRight = CGPoint(x: cardsScrollView.contentOffset.x + 35, y: 0)
        let offsetLeft = CGPoint(x: -15, y: 0)
        let options: UIView.AnimationOptions = [.curveEaseInOut, .allowUserInteraction]
        
        UIView.animate(withDuration: 0.10,
                       delay: 0,
                       options: options,
                       animations: { self.cardsScrollView.setContentOffset(offsetRight, animated: false) },
                       completion:  { _ in
            
            UIView.animate(withDuration: 0.25,
                           delay: 0,
                           options: options,
                           animations: { self.cardsScrollView.setContentOffset(offsetLeft, animated: false) },
                           completion: { _ in
                
                completion?(true)
                
                UIView.animate(withDuration: 0.10,
                               delay: 0,
                               options: options,
                               animations: { self.cardsScrollView.setContentOffset(.zero, animated: false) },
                               completion: nil)
            })
        })
    }
}
