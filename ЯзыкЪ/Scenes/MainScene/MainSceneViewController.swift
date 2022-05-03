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
    
    // MARK: - Methods
    private func createTestCards() -> [Card] {
        return [Card(word: "Juggernaut", translation: "Джаггернаут", description: "[dʒəɡərˌnɔt]", category: Category(categoryKey: "Разное", categoryColor: nil, categoryImage: nil), userEmail: ""), Card(word: "Trifle", translation: "Трайфл", description: "[trʌɪfl]", category: Category(categoryKey: "Еда", categoryColor: nil, categoryImage: nil), userEmail: ""), Card(word: "Syllabub", translation: "Силлабаб", description: "[siləˌbəb]", category: Category(categoryKey: "Еда", categoryColor: nil, categoryImage: nil), userEmail: ""), Card(word: "Wanderlust", translation: "Вандерласт", description: "[wändərˌləst]", category: Category(categoryKey: "Путешествия", categoryColor: nil, categoryImage: nil), userEmail: "")]
    }
    
    private func setupUI() {
    }
    
    private func setupNavigationOptions() {
        self.tabBarController?.title = "Мои карточки"
    }

    // MARK: - Outlets
    
    // MARK: - Actions
    
    // MARK: - Selectors
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDelegate = self
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationOptions()
    }
}
