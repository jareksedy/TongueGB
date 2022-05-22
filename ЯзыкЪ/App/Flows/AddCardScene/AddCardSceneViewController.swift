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
    func displayEmptyDictionaryRecord()
}

// MARK: - View controller
class AddCardSceneViewController: UIViewController {
    lazy var presenter = AddCardScenePresenter(requestFactory: requestFactory)
    weak var delegate: AddCardSceneDelegate?
    
    // MARK: - Services
    let requestFactory = RequestFactory()
    
    // MARK: - Properties
    let categorySuggestions = MockCategoriesProvider().createMockCategories().map { $0.categoryKey }
    
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
        AppDefaults.shared.lastCategory = categoryTextField.text?.trimmingCharacters(in: .whitespaces).capitalizeFirstLetter()
        
        guard let word = wordTextField.text?.trimmingCharacters(in: .whitespaces).capitalizeFirstLetter(),
              let translation = translationTextField.text?.trimmingCharacters(in: .whitespaces).capitalizeFirstLetter(),
              var transcription = transcriptionTextField.text?.trimmingCharacters(in: .whitespaces),
              let category = categoryTextField.text?.trimmingCharacters(in: .whitespaces).capitalizeFirstLetter() else { return }
        
        transcription.contains("[") ? transcription = "\(transcription.dropFirst(2))" : nil
        transcription.contains("]") ? transcription = "\(transcription.dropLast(2))" : nil
        
        dismiss(animated: true, completion: { self.delegate?.didTapAddCard(word: word, translation: translation, transcription: transcription, category: category) })
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
    
    private func checkNeededTextFieldsFilled() -> Bool {
        let word = wordTextField.text?.trimmingCharacters(in: .whitespaces)
        let translation = translationTextField.text?.trimmingCharacters(in: .whitespaces)
        let category = categoryTextField.text?.trimmingCharacters(in: .whitespaces)
        return word != "" && translation != "" && category != ""
    }
    
    private func setAddBarButtonEnabled() {
        addBarButtonItem.isEnabled = checkNeededTextFieldsFilled()
    }
    
    private func animateIn() {
        translationActivityIndicator.isHidden = true
        
        UIView.animate(withDuration: 0.5) {
            self.translationStackView.alpha = 1
        }
    }
    
    private func animateOut() {
        UIView.animate(withDuration: 0.5) {
            self.translationStackView.alpha = 0
        }
    }
    
    private func stripTranscriptionBrackets(_ textField: UITextField) {
        guard textField == transcriptionTextField,
              let text = textField.text,
              text.trimmingCharacters(in: .whitespaces) != "",
              text.contains("["),
              text.contains("]") else { return }
        
        textField.text = "\(textField.text!.dropFirst(2))"
        textField.text = "\(textField.text!.dropLast(2))"
    }
    
    private func addTranscriptionBrackets(_ textField: UITextField) {
        guard textField == transcriptionTextField,
              let text = textField.text?.trimmingCharacters(in: .whitespaces),
              text != "",
              !text.contains("["),
              !text.contains("]") else { return }
        
        textField.text = "[ \(text) ]"
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
            
            if category == "" {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) { [weak self] in
                    guard let self = self else { return }
                    self.categoryTextField.becomeFirstResponder()
                }
            }
            
            self.setAddBarButtonEnabled()
        }
    }
    
    func displayEmptyDictionaryRecord() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.animateIn()
            self.addBarButtonItem.isEnabled = false
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) { [weak self] in
            guard let self = self else { return }
            self.translationTextField.becomeFirstResponder()
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
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        setAddBarButtonEnabled()
        stripTranscriptionBrackets(textField)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        setAddBarButtonEnabled()
        addTranscriptionBrackets(textField)
        
        guard let text = textField.text, text.trimmingCharacters(in: .whitespaces) != "" else { return }
        
        textField.text = text.trimmingCharacters(in: .whitespaces)
        if textField != transcriptionTextField { textField.text = textField.text?.capitalizeFirstLetter() }
        
        guard textField == wordTextField else { return }
        
        presenter.fetchDictionaryRecord(for: text)
        translationActivityIndicator.isHidden = false
        
        translationTextField.text = ""
        transcriptionTextField.text = ""
        categoryTextField.text = ""
    }
    
    // MARK: - Actions
    @IBAction func wordTextFieldEditingChanged(_ sender: Any) {
        animateOut()
        addBarButtonItem.isEnabled = false
    }
    
    @IBAction func translationTextFieldEditingChanged(_ sender: Any) {
        setAddBarButtonEnabled()
    }
    
    @IBAction func categoryTextFieldEditingChanged(_ sender: Any) {
        setAddBarButtonEnabled()
    }
}

extension AddCardSceneViewController {
}
