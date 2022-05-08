//
//  LoginSceneViewController.swift
//  ЯзыкЪ
//
//  Created by Ярослав on 30.04.2022.
//

import UIKit
import AuthenticationServices

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
    
    // MARK: - Properties
    let greetingLabelText = "Добро пожаловать ✌️\nв приложение «ЯзыкЪ» 👅"
    let greetingSubLabelText = "Удобный инструмент для изучения иностранных слов. Войдите в приложение со своим Apple ID"
    let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    let appVersionLabelText = "Версия"
    let loginButtonTitle = "Войти с Apple ID"
    
    let appleIDProvider = ASAuthorizationAppleIDProvider()
    
    // MARK: - Methods
    private func setupUI() {
        greetingLabel.text = greetingLabelText
        greetingSubLabel.text = greetingSubLabelText
        appVersionLabel.text = "\(appVersionLabelText) \(appVersion ?? "0.0.0")"
        loginButton.setTitle(loginButtonTitle, for: .normal)
    }

    // MARK: - Outlets
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var greetingLabel: UILabel!
    @IBOutlet weak var greetingSubLabel: UILabel!
    @IBOutlet weak var appVersionLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    
    // MARK: - Actions
    @IBAction func loginButtonTapped(_ sender: Any) {
    }
    
    // MARK: - Selectors
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDelegate = self
        setupUI()
    }
}
