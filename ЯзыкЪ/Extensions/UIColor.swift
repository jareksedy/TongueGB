//
//  UIColor.swift
//  ЯзыкЪ
//
//  Created by Ярослав on 02.05.2022.
//

import UIKit

extension UIColor {
    static var random: UIColor {
        return UIColor(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1),
            alpha: 1.0
        )
    }
    
    static var randomLight: UIColor {
        return UIColor(
            red: .random(in: 0.35...0.90),
            green: .random(in: 0.35...0.90),
            blue: .random(in: 0.35...0.90),
            alpha: 1.0
        )
    }
    
    static var randomDark: UIColor {
        return UIColor(
            red: .random(in: 0.10...0.65),
            green: .random(in: 0.10...0.65),
            blue: .random(in: 0.10...0.65),
            alpha: 1.0
        )
    }
}
