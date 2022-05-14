//
//  ProfileSceneViewController.swift
//  ЯзыкЪ
//
//  Created by Ярослав on 01.05.2022.
//

import UIKit

// MARK: - Protocol
protocol ProfileSceneViewDelegate: NSObjectProtocol {
}

// MARK: - View controller
class ProfileSceneViewController: UIViewController {
    lazy var presenter = ProfileScenePresenter()
    
    // MARK: - Outlets
    @IBOutlet weak var transcriptionLabel: UILabel!
    @IBOutlet weak var greetingLabel: UILabel!
    @IBOutlet weak var captionCardsNumberLabel: UILabel!
    @IBOutlet weak var cardsNumberLabel: UILabel!
    @IBOutlet weak var captionCategoriesNumberLabel: UILabel!
    @IBOutlet weak var categoriesNumberLabel: UILabel!
    @IBOutlet weak var captionRegistrationDateLabel: UILabel!
    @IBOutlet weak var registrationDateLabel: UILabel!
    @IBOutlet weak var aboutAppHeadingLabel: UILabel!
    @IBOutlet weak var aboutAppTextLabel: UILabel!
    
    // MARK: - Services
    let greetingGenerator = GreetingGenerator()
    
    // MARK: - Properties
    var randomGreeting: Greeting!
    let greetingLabelText = "Теперь вы знаете как поприветствовать кого-нибудь"
    let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    
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
    
    // MARK: - Private methods
    private func setupUI() {
        randomGreeting = greetingGenerator.randomGreeting()
        
        transcriptionLabel.text = randomGreeting?.transcription
        greetingLabel.text = "\(greetingLabelText) \(randomGreeting?.language ?? "")."
        
        cardsNumberLabel.text = "36"
        categoriesNumberLabel.text = "4"
        registrationDateLabel.text = "9 мая 2022"
        
        aboutAppTextLabel.text = "Разработано Like-Minded People. Версия \(appVersion ?? "0.0.0"). Распространяется по лицензии MIT."
    }
    
    private func setupNavigationOptions() {
        self.tabBarController?.title = "\(randomGreeting?.hello ?? "Привет"), Ярослав!"
    }
}

// MARK: - Implementation
extension ProfileSceneViewController: ProfileSceneViewDelegate {
}
