//
//  String.swift
//  ЯзыкЪ
//
//  Created by Ярослав on 05.05.2022.
//

import Foundation

extension String {
    func capitalizeFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
    
    func modifyEmailAddress() -> String {
        return self.replacingOccurrences(of: "[@.]", with: "_", options: .regularExpression, range: nil)
    }
}
