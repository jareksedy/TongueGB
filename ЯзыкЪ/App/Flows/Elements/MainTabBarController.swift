//
//  MainTabBarController.swift
//  ЯзыкЪ
//
//  Created by Ярослав on 19.05.2022.
//

import UIKit

// MARK: - Protocols
protocol AddCardSceneDelegate: AnyObject {
    func didTapAddCard(word: String, translation: String, transcription: String, category: String)
}

class MainTabBarController: UITabBarController, UITabBarControllerDelegate {
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if viewController.children[0] is MainSceneViewController {
            if selectedIndex == 0 {
                let navigationController = self.viewControllers![0] as! MainNavigationController
                let mainSceneViewController = navigationController.topViewController as! MainSceneViewController
                
                mainSceneViewController.scrollToStart(completion: nil)
            }
        }
        
        if viewController.children[0] is AddCardSceneViewController {
            return presentAddCardScenePopover()
        }
        
        return true
    }
    
    private func presentAddCardScenePopover() -> Bool {
        if let addCardSceneViewController = self.storyboard?.instantiateViewController(withIdentifier: "AddCardScene") as? AddCardSceneViewController {
            
            addCardSceneViewController.delegate = self
            let navigationController = UINavigationController(rootViewController: addCardSceneViewController)
            
            navigationController.navigationBar.prefersLargeTitles = false
            navigationController.modalPresentationStyle = .pageSheet
            
            if #available(iOS 15.0, *) {
                if let sheet = navigationController.sheetPresentationController {
                    sheet.detents = [.medium()]
                    sheet.preferredCornerRadius = 24.0
                }
            }
            
            present(navigationController, animated: true)
            return false
        }
        return true
    }
}

// MARK: - Implementation
extension MainTabBarController: AddCardSceneDelegate {
    func didTapAddCard(word: String, translation: String, transcription: String, category: String) {
        let navigationController = self.viewControllers![0] as! MainNavigationController
        let mainSceneViewController = navigationController.topViewController as! MainSceneViewController
        
        mainSceneViewController.addCard(word: word, translation: translation, transcription: transcription, category: category)
        selectedIndex = 0
    }
}
