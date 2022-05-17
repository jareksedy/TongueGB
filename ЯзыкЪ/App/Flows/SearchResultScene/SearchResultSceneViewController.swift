//
//  SearchResultSceneViewController.swift
//  ЯзыкЪ
//
//  Created by Ярослав on 17.05.2022.
//

import UIKit

// MARK: - Protocol
protocol SearchResultSceneViewDelegate: NSObjectProtocol {
}

// MARK: - View controller
class SearchResultSceneViewController: UIViewController {
    lazy var presenter = SearchResultScenePresenter()
    
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
    var cards: [Card]?
    
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
                cardView.category = card.category.categoryKey
                cardsStackView.addArrangedSubview(cardView)
            }
        }
    }
    
    private func setupNavigationOptions() {
        self.navigationItem.title = "Жывотныя"
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
extension SearchResultSceneViewController: SearchResultSceneViewDelegate {
}

