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
    lazy var presenter = SearchScenePresenter()
    
    // MARK: - Outlets
    @IBOutlet weak var categoriesTableView: UITableView!
    
    // MARK: - Services
    let mockCardsProvider = MockCardsProvider()
    let mockCategoriesProvider = MockCategoriesProvider()
    
    // MARK: - Properties
    var categories: [CategoryFirebase]?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchCategories()
        presenter.viewDelegate = self
        
        categoriesTableView.dataSource = self
        categoriesTableView.delegate = self
        categoriesTableView.registerCell(type: CategoryTableViewCell.self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationOptions()
    }
    
    private func setupNavigationOptions() {
        self.navigationItem.title = "Категории"
    }
    
    private func fetchCategories() {
        categories = mockCategoriesProvider.createMockCategories()
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
              let category = categories?[indexPath.row],
              let categoriesCount = categories?.count
        else {
            return UITableViewCell()
        }
        
        let cardsInCategory = mockCardsProvider.createMockCards().filter { $0.category == category.categoryName }.count
        cell.configure(category: category, cardsInCategory: cardsInCategory)
        
        // Set custom selection color
        let selectedBackgroundView = UIView()
        selectedBackgroundView.backgroundColor = .systemGray6
        cell.selectedBackgroundView = selectedBackgroundView
        
        // Remove last cell's separator in TableView
        if indexPath.row == categoriesCount - 1 {
            cell.separatorInset = UIEdgeInsets.init(top: 0, left: categoriesTableView.bounds.width + 1, bottom: 0, right: 0)
        }
        
        return cell
    }
}

extension SearchSceneViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let category = categories?[indexPath.row] else { return }
        categoriesTableView.deselectRow(at: indexPath, animated: true)
        proceedToSearchResult(with: category.categoryName)
    }
}

// MARK: - Implementation
extension SearchSceneViewController: SearchSceneViewDelegate {
    func proceedToSearchResult(with categoryKey: String) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let searchResultSceneViewController = storyboard.instantiateViewController(withIdentifier: "SearchResultScene") as! SearchResultSceneViewController
        searchResultSceneViewController.categoryKey = categoryKey
        self.navigationController?.pushViewController(searchResultSceneViewController, animated: true)
    }
}
