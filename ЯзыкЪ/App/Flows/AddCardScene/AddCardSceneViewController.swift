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

// MARK: - View controller
class AddCardSceneViewController: UIViewController {
    lazy var presenter = AddCardScenePresenter()
    
    // MARK: - Outlets
    @IBOutlet var wordTextField: UITextField!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDelegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationOptions()
        setupUI()
    }
    
    // MARK: - Private methods
    private func setupNavigationOptions() {
        //self.navigationItem.title = "Добавить"
    }
    
    private func setupUI() {
        //self.view.backgroundColor = traitCollection.userInterfaceStyle == .dark ? .randomDark : .randomLight
        wordTextField.becomeFirstResponder()
    }
}

// MARK: - Implementation
extension AddCardSceneViewController: AddCardSceneViewDelegate {
}
