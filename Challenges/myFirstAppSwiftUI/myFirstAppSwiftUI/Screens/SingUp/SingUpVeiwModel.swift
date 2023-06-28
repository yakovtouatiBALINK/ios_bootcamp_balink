//
//  VeiwModelSingUp.swift
//  myFirstAppSwiftUI
//
//  Created by yacov touati on 28/06/2023.
//

import Foundation

class SingUp {
    @Published private var firstname: String = ""
    @Published private var lastname: String = ""
    @Published private var username: String = ""
    @Published private var password: String = ""
    
    @Published var token: String = ""
    @Published var registrationStatus: String = ""
    
    func registerUser(firstname: String, lastname: String, username: String, password: String) async throws -> String {
        do {
            let token = try await UserAPI.createUser(firstname: firstname, lastname: lastname, username: username, password: password)
            registrationStatus = "User registered successfully with token: \(token)"
        } catch APIError.invalidURL {
            registrationStatus = "Invalid API URL"
        } catch APIError.invalidResponse {
            registrationStatus = "Invalid server response"
        } catch APIError.tokenNotFound {
            registrationStatus = "Token not found in response"
        } catch let APIError.registrationFailed(code, message) {
            registrationStatus = "Registration failed with status code \(code): \(message)"
        } catch {
            registrationStatus = "Unknown error occurred"
        }
        return token
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
}
extension String {
    func matches(_ regex: String) -> Bool {
        return range(of: regex, options: .regularExpression) != nil
    }
}







