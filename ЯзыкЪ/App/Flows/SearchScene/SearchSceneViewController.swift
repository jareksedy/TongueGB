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
    let mockCategoriesProvider = MockCategoriesProvider()
    
    // MARK: - Properties
    var categories: [CardsCategory]?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchCategories()
        presenter.viewDelegate = self
        categoriesTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationOptions()
    }
    
    // MARK: - Private methods
    private func setupNavigationOptions() {
        self.tabBarController?.title = "Поиск и категории"
    }
    
    private func fetchCategories() {
        categories = mockCategoriesProvider.createMockCategories()
    }
}
// MARK: - TableView
extension SearchSceneViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int { 1 }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { categories?.count ?? 0 }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = categories?[indexPath.row].categoryKey
        
        return cell
    }
    
    
}

// MARK: - Implementation
extension SearchSceneViewController: SearchSceneViewDelegate {
}
