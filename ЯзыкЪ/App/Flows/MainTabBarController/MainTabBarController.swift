//
//  MainTabBarController.swift
//  ЯзыкЪ
//
//  Created by Ярослав on 02.05.2022.
//

import UIKit
import Firebase

class MainTabBarController: UITabBarController {
    
    // MARK: - Outlets
    @IBOutlet var categoriesBarButtonItem: UIBarButtonItem!
    
    // MARK: - Overrides
    override var selectedViewController: UIViewController? {
        didSet { tabChangedTo(selectedIndex: selectedIndex) }
    }
    
    override var selectedIndex: Int {
        didSet { tabChangedTo(selectedIndex: selectedIndex) }
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.hidesBackButton = true
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    // MARK: - Actions
    @IBAction func categoriesBarButtonItemTapped(_ sender: Any) {
        
        //MARK: - For testing funcs of FirebaseAPI
       let api = FirebaseAPI(controller: self)
//        api.storeWordCard(Card(word: "Test", translation: "Тест", description: "Тестовая модель карточки", category: CardsCategory(categoryKey: "Test Category", categoryColor: "TestColor", categoryImage: "TestImage", userEmail: "test@test.ru"), userEmail: "test@test.ru"))
//        api.storeWordCard(Card(word: "Test One", translation: "Тест Один", description: "Тестовая модель карточки Один", category: CardsCategory(categoryKey: "Test Category One", categoryColor: "TestColorOne", categoryImage: "TestImageOne", userEmail: "test@test.ru"), userEmail: "test@test.ru"))
        api.storeWordCard(Card(word: "Test Three", translation: "Тест Три", description: "Тестовая модель карточки Три", category: CardsCategory(categoryKey: "Test Category Three", categoryColor: "TestColorThree", categoryImage: "TestImageThree", userEmail: "testOne@test.com"), userEmail: "testOne@test.com"))
        
       // api.fetchWordCard("Test", "test@test.ru")
    }
    
    // MARK: - Private methods
     private func tabChangedTo(selectedIndex: Int) {
         if selectedIndex != 0 { self.navigationItem.rightBarButtonItem = nil } else {
             self.navigationItem.rightBarButtonItem = categoriesBarButtonItem }
     }
}
