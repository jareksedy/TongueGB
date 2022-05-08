//
//  AddCardSceneViewController.swift
//  ЯзыкЪ
//
//  Created by Ярослав on 01.05.2022.
//

import UIKit

// MARK: - Protocol
protocol AddCardSceneViewDelegate: NSObjectProtocol {
}

// MARK: - Implementation
extension AddCardSceneViewController: AddCardSceneViewDelegate {
}

// MARK: - Additional extensions
// MARK: - View controller
class AddCardSceneViewController: UIViewController {
    lazy var presenter = AddCardScenePresenter()
    
    // MARK: - Methods
    private func setupUI() {
    }
    
    private func setupNavigationOptions() {
        self.tabBarController?.title = "Добавить"
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
