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
    
    // MARK: - Services
    let greetingGenerator = GreetingGenerator()
    
    // MARK: - Properties
    var randomGreeting: Greeting?
    let greetingLabelText = "Теперь вы знаете как поприветствовать кого-нибудь"
    let welcomeLabelText = "Добро пожаловать! Войдите в приложение с помощью своего Apple ID."
    let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    let appVersionLabelText = "Версия"
    let loginButtonTitle = "Войти с Apple ID"
    
    // MARK: - Methods
    private func setupUI() {
        randomGreeting = greetingGenerator.randomGreeting()
        
        transcriptionLabel.text = randomGreeting?.transcription
        transcriptionLabel.font = UIFont.preferredFont(forTextStyle: .footnote)
        transcriptionLabel.alpha = 0.5
        
        greetingLabel.text = "\(greetingLabelText) \(randomGreeting?.language ?? "")."
        greetingLabel.font = UIFont.preferredFont(forTextStyle: .caption2)
        
        welcomeLabel.text = welcomeLabelText
        welcomeLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        welcomeLabel.textColor = .secondaryLabel
        
        appVersionLabel.text = "\(appVersionLabelText) \(appVersion ?? "0.0.0")"
        appVersionLabel.font = UIFont.monospacedSystemFont(ofSize: 10.0, weight: .light)
        
        loginButton.setTitle(loginButtonTitle, for: .normal)
    }
    
    private func setupNavigationOptions() {
        self.title = randomGreeting?.hello
    }

    // MARK: - Outlets
    @IBOutlet weak var transcriptionLabel: UILabel!
    @IBOutlet weak var greetingLabel: UILabel!
    @IBOutlet weak var welcomeLabel: UILabel!
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
