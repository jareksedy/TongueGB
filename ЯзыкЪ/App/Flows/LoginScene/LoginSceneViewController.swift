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
        
        //MARK: -- Testing API
        let api = FirebaseAPI(self)
        api.authState()
        //api.authUser(User(userEmail: "testTen@test.com", userId: "12345678"))
        //api.createUser(User(userEmail: "testTwo@testTwo.vn", userId: 12345678))
        //api.storeWordCard(Card(word: "Test", translation: "Тест", description: "Модель теста 4", category: CardsCategory(categoryKey: "Category Four", categoryColor: nil, categoryImage: nil, userEmail: "testten@test.com"), userEmail: "testten@test.com"))
        //api.storeCategory(CardsCategory(categoryKey: "Category Five", categoryColor: nil, categoryImage: nil, userEmail: "testten@test.com"))
        //api.authUser(User(userEmail: "test@test.ru", userId: 123456))
       // api.fetchUserByEmail("test@test.ru")
       // api.fetchWordCard("Test", "test@test.ru")
        print ("User by EMAIL: \(String(describing: api.fetchUserByEmail("testTen@test.com")))")
        var card: Card?
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            card = api.fetchWordCard("Test", "testten@test.com")
            print("FETCHED CARD: \(String(describing: card))")
        }
    }
}
