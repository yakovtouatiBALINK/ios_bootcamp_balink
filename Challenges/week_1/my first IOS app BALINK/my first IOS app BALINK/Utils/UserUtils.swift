//
//  RegisterUser.swift
//  my first IOS app BALINK
//
//  Created by yacov touati on 25/06/2023.
//

import Foundation

struct user {
    var firstName: String?
    var lastName: String?
    var userName: String?
    var pasword: String?
}

class UserUtils {
    
    static let `default` = UserUtils()
    
    var token: String?
    
    func registerUser(firstname: String, lastname: String, username: String, password: String) {
        let url = URL(string: "https://balink.onlink.dev/register")!
        
        let user = ["firstname": firstname, "lastname": lastname, "username": username, "password": password]
        let jsonData = try? JSONSerialization.data(withJSONObject: user)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        request.httpBody = jsonData
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                self.token = String(data: data, encoding: .utf8)  ?? ""
            }
            else {
                print("error")
            }
        }.resume()
    }
    
//    func getToken() -> String? {
//
//    }
//
//    func logOut() {
//
//    }
    
}
