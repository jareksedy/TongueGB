//
//  SearchSceneViewController.swift
//  ЯзыкЪ
//
//  Created by Ярослав on 01.05.2022.
//

import UIKit

// MARK: - Protocol
protocol SearchSceneViewDelegate: NSObjectProtocol {
    func proceedToSearchResult(with categoryKey: String)
}

// MARK: - View controller
class SearchSceneViewController: UIViewController {
    lazy var presenter = SearchScenePresenter(firebaseAPI)
    
    // MARK: - Outlets
    @IBOutlet weak var categoriesTableView: UITableView!
    @IBOutlet var categoriesActivityIndicator: UIActivityIndicatorView!
    
    // MARK: - Services
    let mockCardsProvider = MockCardsProvider()
    let mockCategoriesProvider = MockCategoriesProvider()
    let firebaseAPI = FirebaseAPI()
    
    // MARK: - Properties
    var cards: [CardFirebase]?
    var categories: [CategoryWithCount]?
    var cardsInCategory: [Int]?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchCardsAndCategories()
        
        self.presenter.viewDelegate = self
       
        self.categoriesTableView.dataSource = self
        self.categoriesTableView.delegate = self
        self.categoriesTableView.registerCell(type: CategoryTableViewCell.self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationOptions()
    }
    
    private func setupNavigationOptions() {
        self.navigationItem.title = "Категории"
    }
    
    private func fetchCardsAndCategories() {
        presenter.fetchCardsFromFirebase { cards, categories in
            self.categoriesActivityIndicator.isHidden = true
            
            guard let cards = cards, let categories = categories else { return }

            self.cards = cards
            self.categories = categories
            
            self.categoriesTableView.reloadData()
        }
    }
}
// MARK: - TableView
extension SearchSceneViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueCell(withType: CategoryTableViewCell.self, for: indexPath) as? CategoryTableViewCell,
              let category = categories?[indexPath.row]
        else { return UITableViewCell() }
        
        cell.configure(category: category.name, cardsInCategory: category.count)
        
        // Set custom selection color
        let selectedBackgroundView = UIView()
        selectedBackgroundView.backgroundColor = .systemGray6
        cell.selectedBackgroundView = selectedBackgroundView
        
        return cell
    }
}

extension SearchSceneViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let category = categories?[indexPath.row] else { return }
        categoriesTableView.deselectRow(at: indexPath, animated: true)
        proceedToSearchResult(with: category.name)
    }
}

// MARK: - Implementation
extension SearchSceneViewController: SearchSceneViewDelegate {
    func proceedToSearchResult(with categoryKey: String) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let searchResultSceneViewController = storyboard.instantiateViewController(withIdentifier: "SearchResultScene") as! SearchResultSceneViewController
        
        searchResultSceneViewController.categoryKey = categoryKey
        searchResultSceneViewController.cards = cards?.filter { $0.category == categoryKey }
        
        self.navigationController?.pushViewController(searchResultSceneViewController, animated: true)
    }
}
