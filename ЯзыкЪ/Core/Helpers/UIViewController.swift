//
//  UIViewController.swift
//  ЯзыкЪ
//
//  Created by Ярослав on 28.05.2022.
//

import UIKit

extension UIViewController {
    func proceedToLoginScene() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let entryPoint = storyboard.instantiateViewController(withIdentifier: "EntryPoint") as! MainNavigationController
        self.present(entryPoint, animated: true)
    }
}
