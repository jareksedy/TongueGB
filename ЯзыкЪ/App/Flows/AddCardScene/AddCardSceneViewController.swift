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
        setupUI()
        setupGestures()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    // MARK: - Actions
    @IBAction func keyboardReturnTapped(_ sender: Any) {
        view.endEditing(true)
    }
    
    @IBAction func addBarButtonItemTapped(_ sender: Any) {
    }
    
    // MARK: - Overrides
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        guard traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) else { return }
        
        self.view.backgroundColor = traitCollection.userInterfaceStyle == .dark ? .presentationDark : .presentationLight
    }
    
    // MARK: - Private methods
    private func setupUI() {
        self.view.backgroundColor = traitCollection.userInterfaceStyle == .dark ? .presentationDark : .presentationLight
        
        addBarButtonItem.isEnabled = false
        
        wordTextField.delegate = self
        translationTextField.delegate = self
        transcriptionTextField.delegate = self
        categoryTextField.delegate = self
        
        if wordTextField.text == "" {
            wordTextField.becomeFirstResponder()
        }
    }
    
    private func setupGestures() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    private func fetchTranslation() {
        guard wordTextField.text != "" else { return }
        
        translationActivityIndicator.isHidden = false
    }
}

// MARK: - Implementation
extension AddCardSceneViewController: AddCardSceneViewDelegate {
}

// MARK: - Additional extensions
@objc extension AddCardSceneViewController {
    func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension AddCardSceneViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        translationActivityIndicator.isHidden = true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else { return }
        textField.text = text.trimmingCharacters(in: .whitespaces).capitalizeFirstLetter()
        
        fetchTranslation()
    }
}
