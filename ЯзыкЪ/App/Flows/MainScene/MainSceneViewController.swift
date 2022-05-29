//
//  MainSceneViewController.swift
//  ЯзыкЪ
//
//  Created by Ярослав on 01.05.2022.
//

import UIKit
import KeychainSwift

// MARK: - Protocol
protocol MainSceneViewDelegate: NSObjectProtocol {
    func fetchAllCards()
    func addCard(word: String, translation: String, transcription: String, category: String)
    func scrollToStart(completion: ((Bool) -> Void)?)
    func emptyCardTapped()
    func cardLongPressed(word: String)
}

// MARK: - View controller
class MainSceneViewController: UIViewController {
    lazy var presenter = MainScenePresenter(firebaseAPI)
    
    // MARK: - Outlets
    @IBOutlet weak var cardsScrollOverlay: ScrollOverlayView!
    @IBOutlet var cardsScrollView: UIScrollView!
    @IBOutlet var cardsStackView: UIStackView!
    @IBOutlet weak var cardsActivityIndicator: UIActivityIndicatorView!
    
    // MARK: - Constraint outlets
    @IBOutlet weak var cardsScrollViewLeading: NSLayoutConstraint!
    @IBOutlet weak var cardsScrollViewTrailing: NSLayoutConstraint!
    
    // MARK: - Services
    let mockCardsProvider = MockCardsProvider()
    let firebaseAPI = FirebaseAPI()
    let keychain = KeychainSwift()
    
    // MARK: - Properties
    var cards: [CardFirebase]?
    var isEmpty = false
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDelegate = self
        setupConstraints()
        setupUI()
        fetchAllCards()
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
        
        cardsActivityIndicator.isHidden = false
    }
    
    private func reloadCardView() {
        cardsStackView.removeAllArrangedSubviews()
        
        if let cards = cards, cards.count > 0 {
            for card in cards {
                let cardView = CardView()
                
                cardView.word = card.word
                cardView.translation = card.translation
                cardView.transcription = card.transcription
                cardView.category = card.category
                cardView.viewDelegate = self
                self.cardsStackView.addArrangedSubview(cardView)
            }
        } else {
            let emptyCardView = EmptyCardView()
            emptyCardView.viewDelegate = self
            cardsStackView.addArrangedSubview(emptyCardView)
            isEmpty = true
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
    func fetchAllCards() {
        presenter.fetchCardsFromFirebase { cards in
            self.cardsActivityIndicator.isHidden = true
            self.cards = cards
            self.reloadCardView()
        }
    }
    
    func addCard(word: String, translation: String, transcription: String, category: String) {
        presenter.storeAddedWordCardToFirebase(word: word, translation: translation, transcription: transcription, category: category)
        
        if isEmpty {
            cardsStackView.removeAllArrangedSubviews()
            isEmpty = false
        }
        
        let cardView = CardView()
        
        cardView.word = word
        cardView.translation = translation
        cardView.transcription = transcription
        cardView.category = category
        cardView.isFront = true
        
        cardView.alpha = 0
        self.cardsStackView.insertArrangedSubview(cardView, at: 0)
        cardsScrollView.setContentOffset(.zero, animated: false)
        
        UIView.animate(withDuration: 0.18) {
            cardView.alpha = 1
            self.cardsStackView.layoutSubviews()
        }
        
    }
    
    func scrollToStart(completion: ((Bool) -> Void)?) {
        guard cardsScrollView.contentOffset.x > 0 else {
            completion?(true)
            return
        }
        let offsetRight = CGPoint(x: cardsScrollView.contentOffset.x + 25, y: 0)
        let offsetLeft = CGPoint(x: -20, y: 0)
        let options: UIView.AnimationOptions = [.curveEaseInOut, .allowUserInteraction]
        
        UIView.animate(withDuration: 0.15,
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
                
                UIView.animate(withDuration: 0.15,
                               delay: 0,
                               options: options,
                               animations: { self.cardsScrollView.setContentOffset(.zero, animated: false) },
                               completion: nil)
            })
        })
    }
    
    func emptyCardTapped() {
        _ = UIView().presentAddCardScenePopover(delegate: self, viewController: self)
    }
    
    func cardLongPressed(word: String) {
        self.popupAlert(title: "Удалить \(word)?",
                               message: "Вы действительно желаете удалить карточку \(word)?",
                               actionTitles: ["Удалить", "Отмена"],
                               actionStyle: [.destructive, .default],
                               actions: [ { _ in print("Карточка \(word) успешно удалена!") }, nil ],
                               vc: self)
    }
}

// MARK: - Additional extensions
extension MainSceneViewController: AddCardSceneDelegate {
    func didTapAddCard(word: String, translation: String, transcription: String, category: String) {
        addCard(word: word, translation: translation, transcription: transcription, category: category)
    }
}
