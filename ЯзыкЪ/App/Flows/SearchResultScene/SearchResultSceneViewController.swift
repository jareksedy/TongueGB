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
    lazy var presenter = SearchResultScenePresenter(firebaseAPI)
    
    // MARK: - Outlets
    @IBOutlet weak var cardsScrollOverlay: ScrollOverlayView!
    @IBOutlet var cardsScrollView: UIScrollView!
    @IBOutlet var cardsStackView: UIStackView!
    
    // MARK: - Constraint outlets
    @IBOutlet weak var cardsScrollViewLeading: NSLayoutConstraint!
    @IBOutlet weak var cardsScrollViewTrailing: NSLayoutConstraint!
    
    // MARK: - Services
    let mockCardsProvider = MockCardsProvider()
    let firebaseAPI = FirebaseAPI()
    
    // MARK: - Properties
    var categoryKey: String?
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
        cardsScrollOverlay.clipsToBounds = true
        
        cardsStackView.spacing = CGFloat.cardStackSpacing
        cardsStackView.layoutMargins.left = CGFloat.cardStackSpacing / 2
        cardsStackView.layoutMargins.right = CGFloat.cardStackSpacing / 2
        
        if let cards = cards, cards.count > 0 {
            for card in cards {
                let cardView = CardView()
                
                cardView.word = card.word
                cardView.translation = card.translation
                cardView.transcription = card.transcription
                cardView.category = card.category
                cardView.isFront = true
                cardView.viewDelegate = self
                
                self.cardsStackView.addArrangedSubview(cardView)
            }
        }
    }
    
    private func setupNavigationOptions() {
        if let categoryKey = categoryKey {
            self.navigationItem.title = categoryKey
        }
        
        let backButtonImageConfiguration = UIImage.SymbolConfiguration(pointSize: 18, weight: .regular)
        let backButtonImage = UIImage(systemName: "chevron.compact.left")?
            .withRenderingMode(.alwaysOriginal)
            .withConfiguration(backButtonImageConfiguration)
            .withTintColor(.link)
        
        self.navigationController?.navigationBar.backIndicatorImage = backButtonImage
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = backButtonImage
    }
    
    private func setupConstraints() {
        let gap = ((CGFloat.screenWidth - (CGFloat.screenWidth * CGFloat.cardScreenWidthMultiplier)) / 2) - (CGFloat.cardStackSpacing / 2)
        
        cardsScrollViewLeading.constant = gap
        cardsScrollViewTrailing.constant = gap
        
        self.view.layoutIfNeeded()
    }
    
    private func deleteCard(by word: String) {
        cardsStackView.arrangedSubviews.forEach { view in
            let cardView = view as? CardView
            
            if let cardView = cardView, cardView.word == word {
                cardsStackView.killView(cardView)
                cards?.removeAll { $0.word == word }
                
                UIView.animate(withDuration: 0.18) {
                    self.cardsStackView.layoutSubviews()
                }
            }
        }
    }
}

// MARK: - Implementation
extension SearchResultSceneViewController: SearchResultSceneViewDelegate {
}

extension SearchResultSceneViewController: CardActionsViewDelegate {
    func didCallDeleteCard(word: String) {
        guard word != "" else { return }
        
        self.popupAlert(title: "Удалить \(word)?",
                        message: "Вы действительно желаете удалить эту карточку?",
                        actionTitles: ["Удалить", "Отменить"],
                        actionStyle: [.destructive, .default],
                        actions: [ { _ in self.deleteCard(by: word) }, nil ])
    }
}

