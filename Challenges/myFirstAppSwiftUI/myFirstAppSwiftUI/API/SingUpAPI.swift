//
//  RegisterFromAPI.swift
//  myFirstAppSwiftUI
//
//  Created by yacov touati on 28/06/2023.
//

import Foundation

struct UserAPI {
    static var shared = UserAPI()
    private let urlRegister = "https://balink.onlink.dev/users/register"
    
    func createUser(firstname: String, lastname: String, username: String, password: String) async throws -> Void {
        guard let url = URL(string: urlRegister) else {
            throw APIError.invalidURL
        }
        
        let user = User(firstname: firstname, lastname: lastname, username: username, password: password)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.httpBody = try JSONEncoder().encode(user)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.invalidResponse
        }
        
        if httpResponse.statusCode == 201{
            let userInfo = try parseJSON(userData: data)
            DispatchQueue.main.async {
                ProductAPI.shared.token = userInfo.token ?? ""
            }
        } else {
            let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: data)
            throw APIError.registrationFailed(code: httpResponse.statusCode, message: errorResponse.message)
        }
    }
    
    func parseJSON(userData: Data) throws -> LoginResponse {
        let decoder = JSONDecoder()
        return try decoder.decode(LoginResponse.self, from: userData)
        
    }
}

enum APIError: Error {
    case invalidURL
    case invalidResponse
    case tokenNotFound
    case registrationFailed(code: Int, message: String)
    case requestFailed(code: Int, message: String)
}

struct ErrorResponse: Codable {
    let message: String
}







