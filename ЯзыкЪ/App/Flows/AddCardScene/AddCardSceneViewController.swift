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
    @IBOutlet weak var addBarButtonItem: UIBarButtonItem!
    @IBOutlet var wordTextField: UITextField!
    @IBOutlet weak var translationStackView: UIStackView!
    @IBOutlet weak var translationTextField: UITextField!
    @IBOutlet weak var transcriptionTextField: UITextField!
    @IBOutlet weak var categoryTextField: UITextField!
    @IBOutlet weak var translationActivityIndicator: UIActivityIndicatorView!
    
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
    
    // MARK: - Actions
    @IBAction func addBarButtonItemTapped(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    
    // MARK: - Overrides
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        guard traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) else { return }

        self.view.backgroundColor = traitCollection.userInterfaceStyle == .dark ? .presentationDark : .presentationLight
    }
    
    // MARK: - Private methods
    private func setupNavigationOptions() {
        self.navigationItem.title = "Новая карточка"
    }
    
    private func setupUI() {
        self.view.backgroundColor = traitCollection.userInterfaceStyle == .dark ? .presentationDark : .presentationLight
        
        wordTextField.becomeFirstResponder()
    }
}

// MARK: - Implementation
extension AddCardSceneViewController: AddCardSceneViewDelegate {
}
