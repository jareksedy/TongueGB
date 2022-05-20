//
//  MainTabBarController.swift
//  ЯзыкЪ
//
//  Created by Ярослав on 19.05.2022.
//

import UIKit

class MainTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if viewController.children[0] is AddCardSceneViewController {
            if let addCardSceneViewController = self.storyboard?.instantiateViewController(withIdentifier: "AddCardScene") {
                
                let navigationController = UINavigationController(rootViewController: addCardSceneViewController)
                
                navigationController.navigationBar.prefersLargeTitles = false
                navigationController.modalPresentationStyle = .pageSheet
                navigationController.setNavigationBarHidden(true, animated: false)
                
                if #available(iOS 15.0, *) {
                    if let sheet = navigationController.sheetPresentationController {
                        sheet.detents = [.medium()]
                        sheet.preferredCornerRadius = 24.0
                    }
                }
                
                present(navigationController, animated: true)
                return false
            }
        }
        return true
    }
}
