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
    
    func loginUser() async throws {
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
            print(token)
            DispatchQueue.main.async {
                self.registrationStatus = "User registered successfully with token: \(token)"
            }
            print(self.registrationStatus)
        } catch APIError.invalidURL {
            DispatchQueue.main.async {
                self.registrationStatus = "Invalid API URL"
            }
        } catch APIError.invalidResponse {
            DispatchQueue.main.async {
                self.registrationStatus = "Invalid server response"
            }
        } catch APIError.tokenNotFound {
            DispatchQueue.main.async {
                self.registrationStatus = "Token not found in response"
            }
        } catch let APIError.registrationFailed(code, message) {
            DispatchQueue.main.async {
                self.registrationStatus = "Registration failed with status code \(code): \(message)"
            }
        } catch {
            DispatchQueue.main.async {
                self.registrationStatus = "Unknown error occurred"
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







