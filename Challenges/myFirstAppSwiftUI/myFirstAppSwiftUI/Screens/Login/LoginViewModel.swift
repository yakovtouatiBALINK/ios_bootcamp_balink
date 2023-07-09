//
//  LoginViewModel.swift
//  myFirstAppSwiftUI
//
//  Created by yacov touati on 02/07/2023.
//

import Foundation

class LoginViewModel: ObservableObject {
    @Published var username: String = ""
    @Published var password: String = ""
    
    @Published var registrationStatus: String = ""
    
    func loginUser(completion: @escaping (Bool) -> Void) async throws {
        guard isInputValid(username: username, password: password) else {
            DispatchQueue.main.async {
                self.registrationStatus = "Invalid input. Please check the form."
            }
            print(registrationStatus)
            return
        }
        do {
            try await LoginApi.loginUserFromAPI(username: username, password: password)
            let token = UserDefaults.standard.string(forKey: "Token") ?? ""
            completion(true)
            print(token)
            DispatchQueue.main.async {
                self.registrationStatus = "User registered successfully with token: \(token)"
            }
            print(self.registrationStatus)
        } catch {
            DispatchQueue.main.async {
                self.registrationStatus = "Unknown error occurred"
            }
        }
    }
    
    func performRegistration(completion: @escaping (Bool) -> Void) {
        Task {
            do {
                try await loginUser {
                    succes in
                    if succes {
                        completion(true)
                    }
                }
            } catch {
                print("Registration error: \(error)")
                completion(false)
            }
        }
    }
}
        
func isInputValid(username: String, password: String) -> Bool {
    let emailRegex = #"^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#
    let numberRegex = #"^[0-9]+$"#
    
    let isUsernameValid = username.regexMatches(emailRegex)
    let isPasswordValid = password.regexMatches(numberRegex)
    
    return isUsernameValid && isPasswordValid
}

extension String {
    func regexMatches(_ regex: String) -> Bool {
        return range(of: regex, options: .regularExpression) != nil
    }
}







