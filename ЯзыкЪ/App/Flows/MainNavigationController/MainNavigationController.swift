//
//  MainNavigationController.swift
//  ЯзыкЪ
//
//  Created by Ярослав on 03.05.2022.
//

import UIKit

class MainNavigationController: UINavigationController {
    let largeTitleTextAttributes = [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .title1)]
    let titleTextAttributes = [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .subheadline)]
    
    private func setupNavigationOptions() {
        self.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .automatic
        self.navigationBar.largeTitleTextAttributes = largeTitleTextAttributes
        self.navigationBar.titleTextAttributes = titleTextAttributes
        self.navigationBar.layoutMargins.top = 15
        self.navigationBar.layoutMargins.left = 15
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationOptions()
    }
}
