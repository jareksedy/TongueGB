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
        // api.storeCategory(CategoryFirebase(categoryName: "Корабли"))
        //        api.storeWordCard(CardFirebase(word: "Airbus", translation: "Эйрбас", transcription: "Европейский самолет", category: "Самолеты", userEmail: "test@test.ru"))
        //        api.storeWordCard(CardFirebase(word: "Boeing", translation: "Боинг", transcription: "Американский самолет", category: "Самолеты", userEmail: "test@test.ru"))
        //        api.storeWordCard(CardFirebase(word: "Airplane", translation: "Самолет", transcription: "Летательный аппарат", category: "Самолеты", userEmail: "test@test.ru"))
        //        api.storeWordCard(CardFirebase(word: "Ship", translation: "Корабль", transcription: "Плавательный аппарат", category: "Корабли", userEmail: "test@test.ru"))
        //        api.storeWordCard(CardFirebase(word: "Spaceship", translation: "Космический корабль", transcription: "Космический аппарат", category: "Космические корабли", userEmail: "test@test.ru"))
        // api.fetchWordCard("Airplane") { card in
        //    print(card?.translation as Any)
        //}
        // api.fetchCategory("Самолеты") { category in
        //    print(category?.categoryName as Any)
        //}
        //        api.fetchWordCardsByCategory("Самолеты") { cards in
        //            cards?.forEach({ card in
        //                print(card.word)
        //            })
        //        }
        //        api.fetchCategoryList() { categories in
        //            categories?.forEach({ category in
        //                print(category.categoryName)
        //            })
        //        }
        
        api.fetchWordCardsArray() { cards in
            cards?.forEach({ card in
                print(card.word)
            })
        }
    }
}
