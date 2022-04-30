//
//  LoginSceneViewController.swift
//  ЯзыкЪ
//
//  Created by Ярослав on 30.04.2022.
//

import UIKit

// MARK: - Protocol
protocol LoginSceneViewDelegate: NSObjectProtocol {
}

// MARK: - Implementation
extension LoginSceneViewController: LoginSceneViewDelegate {
}

// MARK: - Additional extensions
// MARK: - View controller
class LoginSceneViewController: UIViewController {
    lazy var presenter = LoginScenePresenter()
    
    // MARK: - Methods
    private func setupUI() {
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
}
