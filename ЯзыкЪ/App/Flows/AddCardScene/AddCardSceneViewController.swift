//
//  AddCardSceneViewController.swift
//  ЯзыкЪ
//
//  Created by Ярослав on 01.05.2022.
//

import UIKit

// MARK: - Protocol
protocol AddCardSceneViewDelegate: NSObjectProtocol {
    func displayDictionaryRecord(translation: String, transcription: String, category: String)
}

// MARK: - View controller
class AddCardSceneViewController: UIViewController {
    lazy var presenter = AddCardScenePresenter(requestFactory: requestFactory)
    
    // MARK: - Services
    let requestFactory = RequestFactory()
    
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
        
        setupUI()
        setupGestures()
    }
    
    // MARK: - Actions
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
        translationStackView.alpha = 0
        
        wordTextField.delegate = self
        translationTextField.delegate = self
        transcriptionTextField.delegate = self
        categoryTextField.delegate = self
        
        if wordTextField.text == "" { wordTextField.becomeFirstResponder() }
    }
    
    private func setupGestures() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    private func animateIn() {
        translationActivityIndicator.isHidden = true
        
        UIView.animate(withDuration: 0.5) {
            self.translationStackView.alpha = 1
        }
    }
    
    private func animateOut() {
        translationActivityIndicator.isHidden = false
        
        UIView.animate(withDuration: 0.5) {
            self.translationStackView.alpha = 0
        }
    }
}

// MARK: - Implementation
extension AddCardSceneViewController: AddCardSceneViewDelegate {
    func displayDictionaryRecord(translation: String, transcription: String, category: String) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            self.animateIn()
            self.translationTextField.text = translation
            self.transcriptionTextField.text = transcription
            self.categoryTextField.text = category
        }
    }
    
}

// MARK: - Additional extensions
@objc extension AddCardSceneViewController {
    func dismissKeyboard() {
        translationActivityIndicator.isHidden = true
        view.endEditing(true)
    }
}

extension AddCardSceneViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text, text.trimmingCharacters(in: .whitespaces) != "" else { return }
        
        textField.text = text.trimmingCharacters(in: .whitespaces).capitalizeFirstLetter()
        
        guard textField == wordTextField else { return }
        
        presenter.fetchDictionaryRecord(for: text)
        translationActivityIndicator.isHidden = false
    }
    
    // MARK: - Actions
    @IBAction func wordTextFieldEditingChanged(_ sender: Any) {
        animateOut()
    }
}
