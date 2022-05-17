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
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell") as! CategoryTableViewCell
        cell.configure(categories?[indexPath.row])
        
        let selectedBackgroundView = UIView()
        selectedBackgroundView.backgroundColor = .systemGray6.withAlphaComponent(0.5)
        cell.selectedBackgroundView = selectedBackgroundView
        
        return cell
    }
}

// MARK: - Implementation
extension SearchSceneViewController: SearchSceneViewDelegate {
}
