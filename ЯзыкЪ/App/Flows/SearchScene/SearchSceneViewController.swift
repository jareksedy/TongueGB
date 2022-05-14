//
//  SearchSceneViewController.swift
//  ЯзыкЪ
//
//  Created by Ярослав on 01.05.2022.
//

import UIKit

// MARK: - Protocol
protocol SearchSceneViewDelegate: NSObjectProtocol {
}

// MARK: - Implementation
extension SearchSceneViewController: SearchSceneViewDelegate {
}

// MARK: - Additional extensions
// MARK: - View controller
class SearchSceneViewController: UIViewController {
    lazy var presenter = SearchScenePresenter()
    
    // MARK: - Methods
    private func setupUI() {
    }
    
    private func setupNavigationOptions() {
        self.tabBarController?.title = "Поиск"
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
