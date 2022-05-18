//
//  MainSceneViewController.swift
//  ЯзыкЪ
//
//  Created by Ярослав on 01.05.2022.
//

import UIKit

// MARK: - Protocol
protocol MainSceneViewDelegate: NSObjectProtocol {
    func addCardTapped()
}

// MARK: - View controller
class MainSceneViewController: UIViewController {
    lazy var presenter = MainScenePresenter()
    
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
        
        //MARK: - For testing funcs of FirebaseAPI
       let api = FirebaseAPI(controller: self)
//        api.storeWordCard(Card(word: "Test", translation: "Тест", description: "Тестовая модель карточки", category: CardsCategory(categoryKey: "Test Category", categoryColor: "TestColor", categoryImage: "TestImage", userEmail: "test@test.ru"), userEmail: "test@test.ru"))
//        api.storeWordCard(Card(word: "Test One", translation: "Тест Один", description: "Тестовая модель карточки Один", category: CardsCategory(categoryKey: "Test Category One", categoryColor: "TestColorOne", categoryImage: "TestImageOne", userEmail: "test@test.ru"), userEmail: "test@test.ru"))
//        api.storeWordCard(Card(word: "Test Three", translation: "Тест Три", description: "Тестовая модель карточки Три", category: CardsCategory(categoryKey: "Test Category Three", categoryColor: "TestColorThree", categoryImage: "TestImageThree", userEmail: "testOne@test.com"), userEmail: "testOne@test.com"))
        let card = api.fetchWordCard("Test", "test@test.ru")
    
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
        } else {
            let emptyCardView = EmptyCardView()
            
            emptyCardView.viewDelegate = self
            cardsStackView.addArrangedSubview(emptyCardView)
        }
    }
    
    private func setupNavigationOptions() {
        self.tabBarController?.title = "Мои карточки"
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
    func addCardTapped() {}
}
