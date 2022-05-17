//
//  MainTabBarController.swift
//  ЯзыкЪ
//
//  Created by Ярослав on 02.05.2022.
//

import UIKit

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
        
        //self.navigationItem.hidesBackButton = true
        //self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    // MARK: - Actions
    @IBAction func categoriesBarButtonItemTapped(_ sender: Any) {
    }
    
    // MARK: - Private methods
     private func tabChangedTo(selectedIndex: Int) {
         if selectedIndex != 0 { self.navigationItem.rightBarButtonItem = nil } else {
             self.navigationItem.rightBarButtonItem = categoriesBarButtonItem }
     }
}
