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

// MARK: - Implementation
extension ProfileSceneViewController: ProfileSceneViewDelegate {
}

// MARK: - Additional extensions
// MARK: - View controller
class ProfileSceneViewController: UIViewController {
    lazy var presenter = ProfileScenePresenter()
    
    // MARK: - Services
    let greetingGenerator = GreetingGenerator()
    
    // MARK: - Properties
    var randomGreeting: Greeting?
    let greetingLabelText = "Теперь вы знаете как поприветствовать кого-нибудь"
    let captionCardsNumberLabelText = "Количество карточек"
    let captionCategoriesNumberLabelText = "Количество категорий"
    let captionRegistrationDateLabelText = "Дата регистрации"
    let aboutAppHeadingLabelText = "О приложении"
    let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    
    // MARK: - Methods
    private func setupUI() {
        randomGreeting = greetingGenerator.randomGreeting()
        
        transcriptionLabel.text = randomGreeting?.transcription
        transcriptionLabel.font = UIFont.preferredFont(forTextStyle: .footnote)
        transcriptionLabel.alpha = 0.5
        
        greetingLabel.text = "\(greetingLabelText) \(randomGreeting?.language ?? "")."
        greetingLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        
        captionCardsNumberLabel.text = captionCardsNumberLabelText
        captionCardsNumberLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        captionCardsNumberLabel.textColor = .secondaryLabel
        
        cardsNumberLabel.text = "48"
        cardsNumberLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        cardsNumberLabel.textColor = .secondaryLabel
        
        captionCategoriesNumberLabel.text = captionCategoriesNumberLabelText
        captionCategoriesNumberLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        captionCategoriesNumberLabel.textColor = .secondaryLabel
        
        categoriesNumberLabel.text = "14"
        categoriesNumberLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        categoriesNumberLabel.textColor = .secondaryLabel
        
        captionRegistrationDateLabel.text = captionRegistrationDateLabelText
        captionRegistrationDateLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        captionRegistrationDateLabel.textColor = .secondaryLabel
        
        registrationDateLabel.text = "9 мая 2022"
        registrationDateLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        registrationDateLabel.textColor = .secondaryLabel
        
        aboutAppHeadingLabel.text = aboutAppHeadingLabelText
        aboutAppHeadingLabel.font = UIFont.preferredFont(forTextStyle: .title3)
        
        aboutAppTextLabel.text = "Разработано Like-Minded People. Денис Казарин, Кирилл Сухов, Ярослав Седышев. Версия \(appVersion ?? "0.0.0"). Распространяется по лицензии MIT."
        aboutAppTextLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        aboutAppTextLabel.textColor = .secondaryLabel
    }
    
    private func setupNavigationOptions() {
        self.tabBarController?.title = "\(randomGreeting?.hello ?? "Привет"), Ярослав!"
    }

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
    
    // MARK: - Actions
    
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
