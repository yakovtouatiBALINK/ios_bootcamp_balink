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
    
    @Published var registrationStatus: String = ""
    
    // func that get the input from the user check if tthe input is valid and send the data tu the func that create a nwe user
    func registerUser(completion: @escaping (Bool) -> Void) async throws {
        guard isInputValid(firstname: firstname, lastname: lastname, username: username, password: password) else {
            DispatchQueue.main.async {
                self.registrationStatus = "Invalid input. Please check the form."
            }
            print(registrationStatus)
            return
        }
        do {
            try await UserAPI.shared.createUser(firstname: firstname, lastname: lastname, username: username, password: password)
            completion(true)
        } catch {
            DispatchQueue.main.async {
                self.registrationStatus = "Unknown error occurred"
            }
        }
    }
    
    //func that check if the regstration sucsess
    func performRegistration(completion: @escaping (Bool) -> Void) {
        Task {
            do {
                try await registerUser {
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

// func that check if the input is valid
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




