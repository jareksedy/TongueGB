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
    
    // MARK: - Methods
    private func setupUI() {
        randomGreeting = greetingGenerator.randomGreeting()
        
        transcriptionLabel.text = randomGreeting?.transcription
        transcriptionLabel.font = UIFont.preferredFont(forTextStyle: .footnote)
        transcriptionLabel.alpha = 0.5
        
        greetingLabel.text = "\(greetingLabelText) \(randomGreeting?.language ?? "")."
        greetingLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
    }
    
    private func setupNavigationOptions() {
        self.tabBarController?.title = "\(randomGreeting?.hello ?? "Привет"), Ярослав!"
    }

    // MARK: - Outlets
    @IBOutlet weak var transcriptionLabel: UILabel!
    @IBOutlet weak var greetingLabel: UILabel!
    
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
