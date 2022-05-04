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
    
    // MARK: - Properties
    var frame = CGRect.zero
    
    // MARK: - Methods
    private func createTestCards() -> [Card] {
        return [Card(word: "Juggernaut", translation: "Джаггернаут", description: "[dʒəɡərˌnɔt]", category: Category(categoryKey: "Разное", categoryColor: nil, categoryImage: nil), userEmail: ""), Card(word: "Trifle", translation: "Трайфл", description: "[trʌɪfl]", category: Category(categoryKey: "Еда", categoryColor: nil, categoryImage: nil), userEmail: ""), Card(word: "Syllabub", translation: "Силлабаб", description: "[siləˌbəb]", category: Category(categoryKey: "Еда", categoryColor: nil, categoryImage: nil), userEmail: ""), Card(word: "Wanderlust", translation: "Вандерласт", description: "[wändərˌləst]", category: Category(categoryKey: "Путешествия", categoryColor: nil, categoryImage: nil), userEmail: "")]
    }
    
    private func setupUI() {
        cardsScrollOverlay.referenceView = cardsScrollView
        
        cardsStackView.spacing = stackSpacing
        cardsStackView.layoutMargins.left = stackSpacing / 2
        cardsStackView.layoutMargins.right = stackSpacing / 2
        
        let cards = createTestCards()
        
        for card in cards {
            let cardView = CardView()
            
            cardView.card = card
            cardView.screenWidthMultiplier = screenWidthMultiplier
            
            cardsStackView.addArrangedSubview(cardView)
        }
    }
    
    private func setupNavigationOptions() {
        self.tabBarController?.title = "Мои карточки"
    }
    
    private func setupConstraints() {
        let gap = ((screenWidth - (screenWidth * screenWidthMultiplier)) / 2) - (stackSpacing / 2)
        
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
