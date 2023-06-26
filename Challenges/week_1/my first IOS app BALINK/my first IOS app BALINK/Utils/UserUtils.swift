//
//  RegisterUser.swift
//  my first IOS app BALINK
//
//  Created by yacov touati on 25/06/2023.
//

import Foundation

// class that handel all user info
class UserUtils {
    var token: String?
    
    // function that get the input from the user and return Token and save the toke i the UserDefaults
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
                UserDefaults.standard.set(self.token, forKey: "Token")
            }
            else {
                print("error")
            }
        }.resume()
    }
}

extension UserUtils {
    //function that return the Token from the UserDefaults
    func getToken() -> String? {
        return UserDefaults.standard.string(forKey: "Token")
    }
    
    //function that delete the toke from the UserDefaults
    func logOut() {
        UserDefaults.standard.removeObject(forKey: "Token")
    }
    
    // fuctio that check the iput validation
    func validateClientInput(firstName: String, lastName: String, username: String, password: String) -> Bool {
        
        let nameRegex = "^[a-zA-Z]+$"
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let passwordRegex = "^[0-9]+$"
        
        let firstNameIsValid = NSPredicate(format: "SELF MATCHES %@", nameRegex).evaluate(with: firstName)
        let lastNameIsValid = NSPredicate(format: "SELF MATCHES %@", nameRegex).evaluate(with: lastName)
        let usernameIsValid = NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: username)
        let passwordIsValid = NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: password)
        
        return firstNameIsValid && lastNameIsValid && usernameIsValid && passwordIsValid
    }
}
