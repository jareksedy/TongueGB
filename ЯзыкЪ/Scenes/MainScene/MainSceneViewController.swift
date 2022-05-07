//
//  MainSceneViewController.swift
//  ЯзыкЪ
//
//  Created by Ярослав on 01.05.2022.
//

import UIKit

// MARK: - Protocol
protocol MainSceneViewDelegate: NSObjectProtocol {
}

// MARK: - Implementation
extension MainSceneViewController: MainSceneViewDelegate {
}

// MARK: - Additional extensions

// MARK: - View controller
class MainSceneViewController: UIViewController {
    lazy var presenter = MainScenePresenter()
    
    // MARK: - Services
    let tempUICardMockProvider = TempUICardMockProvider()
    
    // MARK: - Properties
    var cards: [Card]?
    var frame = CGRect.zero
    
    // MARK: - Methods
    private func fetchCards() {
        cards = tempUICardMockProvider.createMockCards()
    }
    
    private func setupUI() {
        cardsScrollOverlay.referenceView = cardsScrollView
        
        cardsStackView.spacing = cardStackSpacing
        cardsStackView.layoutMargins.left = cardStackSpacing / 2
        cardsStackView.layoutMargins.right = cardStackSpacing / 2
        
        fetchCards()
        
        if let cards = cards, cards.count > 0 {
            for card in cards {
                let cardView = CardView()
                
                cardView.word = card.word
                cardView.translation = card.translation
                cardView.transcription = card.description
                cardView.category = card.category.categoryKey
                
                cardView.screenWidthMultiplier = cardScreenWidthMultiplier
                
                cardsStackView.addArrangedSubview(cardView)
            }
        } else {
            let emptyCardView = EmptyCardView()
            emptyCardView.screenWidthMultiplier = cardScreenWidthMultiplier
            
            cardsStackView.addArrangedSubview(emptyCardView)
        }
    }
    
    private func setupNavigationOptions() {
        self.tabBarController?.title = "Мои карточки"
    }
    
    private func setupConstraints() {
        let gap = ((screenWidth - (screenWidth * cardScreenWidthMultiplier)) / 2) - (cardStackSpacing / 2)
        
        cardsScrollViewLeading.constant = gap
        cardsScrollViewTrailing.constant = gap
        self.view.layoutIfNeeded()
    }
    
    // MARK: - Outlets
    @IBOutlet weak var cardsScrollOverlay: ScrollOverlayView!
    @IBOutlet var cardsScrollView: UIScrollView!
    @IBOutlet var cardsStackView: UIStackView!
    
    // MARK: - Constraint outlets
    @IBOutlet weak var cardsScrollViewLeading: NSLayoutConstraint!
    @IBOutlet weak var cardsScrollViewTrailing: NSLayoutConstraint!
    
    // MARK: - Actions
    
    // MARK: - Selectors
    
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
}
