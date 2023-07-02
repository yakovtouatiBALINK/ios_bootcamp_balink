//
//  VeiwModelSingUp.swift
//  myFirstAppSwiftUI
//
//  Created by yacov touati on 28/06/2023.
//

import Foundation

class SingUp: ObservableObject {
    @Published var firstname: String = ""
    @Published var lastname: String = ""
    @Published var username: String = ""
    @Published var password: String = ""
    
//    @Published var token: String = ""
    @Published var registrationStatus: String = ""
    
    func registerUser() async throws {
        guard isInputValid(firstname: firstname, lastname: lastname, username: username, password: password) else {
            DispatchQueue.main.async {
                self.registrationStatus = "Invalid input. Please check the form."
            }
            print(registrationStatus)
            return
        }
        do {
            try await UserAPI.shared.createUser(firstname: firstname, lastname: lastname, username: username, password: password)
            let token = UserDefaults.standard.string(forKey: "Token") ?? ""
//            self.token = token
            DispatchQueue.main.async {
                self.registrationStatus = "User registered successfully with token: \(token)"
                print(self.registrationStatus)
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
        
func isInputValid(firstname: String, lastname: String, username: String, password: String) -> Bool {
    let nameRegex = #"^[a-zA-Z]+$"#
    let emailRegex = #"^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#
    let numberRegex = #"^[0-9]+$"#
    
    let isFirstNameValid = firstname.matches(nameRegex)
    let isLastNameValid = lastname.matches(nameRegex)
    let isUsernameValid = username.matches(emailRegex)
    let isPasswordValid = password.matches(numberRegex)
    
    return isFirstNameValid && isLastNameValid && isUsernameValid && isPasswordValid
}

extension String {
    func matches(_ regex: String) -> Bool {
        return range(of: regex, options: .regularExpression) != nil
    }
}






