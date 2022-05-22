//
//  AppDefaults.swift
//  ЯзыкЪ
//
//  Created by Ярослав on 22.05.2022.
//

import Foundation
import Foil

final class AppDefaults {
    static let shared = AppDefaults()
    
    // Last entered category
    @WrappedDefaultOptional(key: "lastCategory")
    var lastCategory: String?
}
