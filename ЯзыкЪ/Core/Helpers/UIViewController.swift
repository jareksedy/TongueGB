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
    
    func popupAlert(title: String?, message: String?, actionTitles:[String?], actionStyle:[UIAlertAction.Style], actions:[((UIAlertAction) -> Void)?], vc: UIViewController) {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
            for (index, title) in actionTitles.enumerated() {
                 let action = UIAlertAction(title: title, style: actionStyle[index], handler: actions[index])
                 alert.addAction(action)
            }
            vc.present(alert, animated: true, completion: nil)
       }
}
