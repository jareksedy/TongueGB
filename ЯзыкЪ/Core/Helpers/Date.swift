//
//  Date.swift
//  ЯзыкЪ
//
//  Created by Denis Kazarin on 28.05.2022.
//

import Foundation

extension Date {
    public func dateFormatted() -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.dateFormat = "dd MMMM yyyy"
        return formatter.string(from: self)
    }
}
