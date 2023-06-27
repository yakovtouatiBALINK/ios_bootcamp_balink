//
//  RegisterUser.swift
//  my first IOS app BALINK
//
//  Created by yacov touati on 25/06/2023.
//

import Foundation

// class that handel all user info
class UserUtils {
    //function that return the Token from the UserDefaults
    static func getToken() -> String? {
        return UserDefaults.standard.string(forKey: "Token")
    }
    
    //function that delete the toke from the UserDefaults
    static func logOut() {
        UserDefaults.standard.removeObject(forKey: "Token")
    }
    
    static func setToken(_ token: String) {
        UserDefaults.standard.set(token, forKey: "Token")
    }
}
