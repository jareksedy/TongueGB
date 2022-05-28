//
//  ProfileSceneViewController.swift
//  ЯзыкЪ
//
//  Created by Ярослав on 01.05.2022.
//

import UIKit
import KeychainSwift

// MARK: - Protocol
protocol ProfileSceneViewDelegate: NSObjectProtocol {
    func proceedToLoginScreen()
}

// MARK: - View controller
class ProfileSceneViewController: UIViewController {
    lazy var presenter = ProfileScenePresenter(firebaseAPI)
    
    // MARK: - Outlets
    @IBOutlet weak var transcriptionLabel: UILabel!
    @IBOutlet weak var greetingLabel: UILabel!
    @IBOutlet weak var aboutAppHeadingLabel: UILabel!
    @IBOutlet weak var aboutAppTextLabel: UILabel!
    @IBOutlet weak var logoutButton: UIBarButtonItem!
    @IBOutlet weak var quickStatsTableView: UITableView!
    
    // MARK: - Properties
    var quickStatsData: [[String]] = []
    let firebaseAPI = FirebaseAPI()
    
    // MARK: - Services
    let keychain = KeychainSwift()
    let greetingGenerator = GreetingGenerator()
    
    // MARK: - Properties
    var randomGreeting: Greeting!
    let greetingLabelText = "Теперь вы знаете как поприветствовать кого-нибудь"
    let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.viewDelegate = self
        quickStatsTableView.dataSource = self
        quickStatsTableView.registerCell(type: QuickStatsTableViewCell.self)
        
        setupUI()
        
        keychain.synchronizable = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationOptions()
        fetchProfileData()
    }
    
    // MARK: - Actions
    @IBAction func logoutButtonTapped(_ sender: Any) {
        presenter.logOut()
    }
    
    // MARK: - Private methods
    private func setupUI() {
        randomGreeting = greetingGenerator.randomGreeting()
        
        transcriptionLabel.text = randomGreeting?.transcription
        greetingLabel.text = "\(greetingLabelText) \(randomGreeting?.language ?? "")."
        
        aboutAppTextLabel.text = "Разработано Like-Minded People. Версия \(appVersion ?? "0.0.0"). Распространяется по лицензии MIT."
    }
    
    private func setupNavigationOptions() {
        if let userName = keychain.get("userName") {
            self.navigationItem.title = "\(randomGreeting!.hello), \(userName)!"
        } else {
            self.navigationItem.title = "\(randomGreeting!.hello)!"
        }
    }
    
    private func fetchProfileData() {
        presenter.fetchProfileInfo { profile in
            guard let profile = profile else { return }
            self.quickStatsData = [["Количество категорий", "\(profile.categoriesCount)"],
                              ["Количество карточек", "\(profile.cardsCount)"],
                              ["Дата регистрации", "\(profile.creationDate)"]]

        }
        
    }
}

// MARK: - TableView
extension ProfileSceneViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quickStatsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueCell(withType: QuickStatsTableViewCell.self, for: indexPath) as? QuickStatsTableViewCell
        else { return UITableViewCell() }
        
        cell.configure(caption: quickStatsData[indexPath.row][0], value: quickStatsData[indexPath.row][1])
        
        return cell
    }
}

// MARK: - Implementation
extension ProfileSceneViewController: ProfileSceneViewDelegate {
    func proceedToLoginScreen() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let entryPoint = storyboard.instantiateViewController(withIdentifier: "EntryPoint") as! MainNavigationController
        present(entryPoint, animated: true)
    }
}
