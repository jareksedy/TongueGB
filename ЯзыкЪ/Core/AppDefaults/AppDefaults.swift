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
    
    // Apple User ID
    @WrappedDefaultOptional(key: "userID")
    var userID: String?
    
    // User's name
    @WrappedDefaultOptional(key: "userName")
    var userName: String?
    
    // User's email
    @WrappedDefaultOptional(key: "userEmail")
    var userEmail: String?
    
    // User is signed in
    @WrappedDefault(key: "userSignedIn")
    var userSignedIn: Bool = false
}
