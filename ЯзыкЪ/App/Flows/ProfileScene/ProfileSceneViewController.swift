//
//  ProfileSceneViewController.swift
//  ЯзыкЪ
//
//  Created by Ярослав on 01.05.2022.
//

import UIKit

// MARK: - Protocol
protocol ProfileSceneViewDelegate: NSObjectProtocol {
    func logOut()
}

// MARK: - View controller
class ProfileSceneViewController: UIViewController {
    lazy var presenter = ProfileScenePresenter()
    
    // MARK: - Outlets
    @IBOutlet weak var transcriptionLabel: UILabel!
    @IBOutlet weak var greetingLabel: UILabel!
    @IBOutlet weak var aboutAppHeadingLabel: UILabel!
    @IBOutlet weak var aboutAppTextLabel: UILabel!
    @IBOutlet weak var logoutButton: UIBarButtonItem!
    @IBOutlet weak var quickStatsTableView: UITableView!
    
    // MARK: - Properties
    var quickStatsData: [[String]] = []
    
    // MARK: - Services
    let greetingGenerator = GreetingGenerator()
    lazy var categoriesCount = MockCategoriesProvider().createMockCategories().count
    lazy var cardsCount = MockCardsProvider().createMockCards().count
    
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
        generateData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationOptions()
    }
    
    // MARK: - Actions
    @IBAction func logoutButtonTapped(_ sender: Any) {
        logOut()
    }
    
    // MARK: - Private methods
    private func setupUI() {
        randomGreeting = greetingGenerator.randomGreeting()
        
        transcriptionLabel.text = randomGreeting?.transcription
        greetingLabel.text = "\(greetingLabelText) \(randomGreeting?.language ?? "")."
        
        aboutAppTextLabel.text = "Разработано Like-Minded People. Версия \(appVersion ?? "0.0.0"). Распространяется по лицензии MIT."
    }
    
    private func setupNavigationOptions() {
        self.navigationItem.title = "\(randomGreeting?.hello ?? "Привет"), Ярослав!"
    }
    
    private func generateData() {
        quickStatsData = [["Количество категорий", "\(categoriesCount)"],
                          ["Количество карточек", "\(cardsCount)"],
                          ["Дата регистрации", "9 мая 2022"]]
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
        
        // Remove last cell's separator in TableView
        if indexPath.row == quickStatsData.count - 1 {
            cell.separatorInset = UIEdgeInsets.init(top: 0, left: quickStatsTableView.bounds.width + 1, bottom: 0, right: 0)
        }
        
        return cell
    }
}

// MARK: - Implementation
extension ProfileSceneViewController: ProfileSceneViewDelegate {
    func logOut() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let entryPoint = storyboard.instantiateViewController(withIdentifier: "EntryPoint") as! MainNavigationController
        present(entryPoint, animated: true)
    }
}
