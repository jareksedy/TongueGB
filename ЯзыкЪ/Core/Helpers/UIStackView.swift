//
//  UIStackView.swift
//  ЯзыкЪ
//
//  Created by Ярослав on 19.05.2022.
//

import UIKit

extension UIStackView {
    public func insertArrangedSubviewAnimated(_ view: UIView, at stackIndex: Int) {
        
        view.alpha = 0
        self.insertArrangedSubview(view, at: stackIndex)
        
        UIView.animate(withDuration: 0.225,
                       animations: { view.alpha = 1; self.layoutIfNeeded() },
                       completion: nil)
    }
}
