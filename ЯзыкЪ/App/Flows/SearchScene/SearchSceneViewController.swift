//
//  SearchSceneViewController.swift
//  ЯзыкЪ
//
//  Created by Ярослав on 01.05.2022.
//

import UIKit

// MARK: - Protocol
protocol SearchSceneViewDelegate: NSObjectProtocol {
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
    var categories: [CardsCategory]?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchCategories()
        presenter.viewDelegate = self
        
        categoriesTableView.dataSource = self
        categoriesTableView.registerCell(type: CategoryTableViewCell.self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationOptions()
    }
    
    private func setupNavigationOptions() {
        self.tabBarController?.title = "Категории"
    }
    
    private func fetchCategories() {
        categories = mockCategoriesProvider.createMockCategories()
    }
}
// MARK: - TableView
extension SearchSceneViewController: UITableViewDelegate, UITableViewDataSource {
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
        
        let cardsInCategory = mockCardsProvider.createMockCards().filter { $0.category.categoryKey == category.categoryKey }.count
        cell.configure(category: category, cardsInCategory: cardsInCategory)
        
        // Set custom selection color
        let selectedBackgroundView = UIView()
        selectedBackgroundView.backgroundColor = .systemGray6.withAlphaComponent(0.75)
        cell.selectedBackgroundView = selectedBackgroundView
        
        // Remove last cell's separator in TableView
        if indexPath.row == categoriesCount - 1 {
            cell.separatorInset = UIEdgeInsets.init(top: 0, left: categoriesTableView.bounds.width + 1, bottom: 0, right: 0)
        }
        
        return cell
    }
}

// MARK: - Implementation
extension SearchSceneViewController: SearchSceneViewDelegate {
}
