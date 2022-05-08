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
    func proceedToMainScene()
}

// MARK: - Implementation
extension LoginSceneViewController: LoginSceneViewDelegate {
    func proceedToMainScene() {
        let mainTabBarController = self.storyboard?.instantiateViewController(withIdentifier: "MainTabBar") as! UITabBarController
        self.navigationController?.pushViewController(mainTabBarController, animated: true)
    }
}

// MARK: - Additional extensions
// MARK: - View controller
class LoginSceneViewController: UIViewController {
    lazy var presenter = LoginScenePresenter()
    
    // MARK: - Properties
    let greetingLabelText = "Привет ✌️"
    let greetingSubLabelText = "«ЯзыкЪ» 👅 приветствует тебя! «ЯзыкЪ» — это удобный инструмент для изучения иностранных слов."
    let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    let appVersionLabelText = "Версия"
    let loginButtonTitle = "Войти с Apple ID"
    
    let appleIDProvider = ASAuthorizationAppleIDProvider()
    
    // MARK: - Methods
    private func setupUI() {
        appVersionLabel.text = "\(appVersionLabelText) \(appVersion ?? "0.0.0")"
        appVersionLabel.font = UIFont.monospacedSystemFont(ofSize: 10.0, weight: .light)
        
        loginButton.setTitle(loginButtonTitle, for: .normal)
    }
    
    private func setupNavigationOptions() {
        self.title = "Добрый день"
    }

    // MARK: - Outlets
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var greetingLabel: UILabel!
    @IBOutlet weak var greetingSubLabel: UILabel!
    @IBOutlet weak var appVersionLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    
    // MARK: - Actions
    @IBAction func loginButtonTapped(_ sender: Any) {
        proceedToMainScene()
    }
    
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
