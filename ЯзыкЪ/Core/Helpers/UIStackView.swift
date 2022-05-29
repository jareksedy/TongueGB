//
//  UIStackView.swift
//  ЯзыкЪ
//
//  Created by Ярослав on 26.05.2022.
//

import UIKit

extension UIStackView {    
    func killView(_ view: UIView) {
        removeArrangedSubview(view)
        view.removeFromSuperview()
    }
    
    func killAllViews() {
        arrangedSubviews.forEach { view in
            killView(view)
        }
    }
}
