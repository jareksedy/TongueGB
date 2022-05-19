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
            red: .random(in: 0.35...0.98),
            green: .random(in: 0.35...0.98),
            blue: .random(in: 0.35...0.98),
            alpha: 1.0
        )
    }
    
    static var randomDark: UIColor {
        return UIColor(
            red: .random(in: 0.2...0.65),
            green: .random(in: 0.2...0.65),
            blue: .random(in: 0.2...0.65),
            alpha: 1.0
        )
    }
    
    static var presentationLight: UIColor {
        return UIColor(red: 0.97, green: 0.93, blue: 0.87, alpha: 1.00)
    }
    
    static var presentationDark: UIColor {
        return UIColor(red: 0.22, green: 0.24, blue: 0.39, alpha: 1.00)
    }
}
