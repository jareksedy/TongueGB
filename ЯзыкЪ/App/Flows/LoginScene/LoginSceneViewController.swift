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

// MARK: - View controller
class LoginSceneViewController: UIViewController {
    lazy var presenter = LoginScenePresenter()
    
    // MARK: - Outlets
    @IBOutlet weak var transcriptionLabel: UILabel!
    @IBOutlet weak var greetingLabel: UILabel!
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var appVersionLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    
    // MARK: - Services
    let greetingGenerator = GreetingGenerator()
    
    // MARK: - Properties
    var randomGreeting: Greeting!
    let greetingLabelText = "Теперь вы знаете как поприветствовать кого-нибудь"
    let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    let appVersionLabelText = "Разработано Like-Minded People. Версия"
    
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
    
    // MARK: - Actions
    @IBAction func loginButtonTapped(_ sender: Any) {
        proceedToMainScene()
        
        //MARK: -  Test API
        testAPI()
    }
    
    // MARK: - Private methods
    private func setupUI() {
        randomGreeting = greetingGenerator.randomGreeting()
        
        transcriptionLabel.text = randomGreeting.transcription
        greetingLabel.text = "\(greetingLabelText) \(randomGreeting.language)."
        appVersionLabel.text = "\(appVersionLabelText) \(appVersion ?? "0.0.0")."
    }
    
    private func setupNavigationOptions() {
        self.navigationItem.title = "\(randomGreeting.hello)!"
    }
}

// MARK: - Implementation
extension LoginSceneViewController: LoginSceneViewDelegate {
    func proceedToMainScene() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mainTabBarController = storyboard.instantiateViewController(withIdentifier: "MainTabBar") as! UITabBarController
        present(mainTabBarController, animated: true)
    }
    
    
    func testAPI() {
        let api = FirebaseAPI(controller: self)
        api.authUser(UserFirebase(userEmail: "test@test.ru", userId: "123456"))
        api.storeCategory(CategoryFirebase(categoryName: "Самолеты"))
        api.storeWordCard(CardFirebase(word: "Airplane", translation: "Самолет", description: "Летательный аппарат", category: CategoryFirebase(categoryName: "Самолеты"), userEmail: "test@test.ru"))
    }
    
}
