//
//  UIViewController.swift
//  ЯзыкЪ
//
//  Created by Ярослав on 29.05.2022.
//

import UIKit

extension UIViewController {
    func quickAlert(message: String, completionHandler: (() -> Void)? = nil) {
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        self.present(alert, animated: true, completion: nil)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.75) {
            self.dismiss(animated: true)
            completionHandler?()
        }
    }
}
