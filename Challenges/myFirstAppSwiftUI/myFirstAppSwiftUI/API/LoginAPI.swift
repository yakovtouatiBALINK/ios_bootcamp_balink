//
//  Login.swift
//  myFirstAppSwiftUI
//
//  Created by yacov touati on 02/07/2023.
//

import Foundation

struct LoginApi {
    static func loginUserFromAPI(username: String, password: String) async throws -> Void {
        guard let url = URL(string: "https://balink.onlink.dev/register") else {
            throw APIError.invalidURL
        }
        
        let loginUser = Login(username: username, password: password)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.httpBody = try JSONEncoder().encode(loginUser)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.invalidResponse
        }
        
        if httpResponse.statusCode == 201 {
            let jsonResponse = try JSONDecoder().decode(LoginResponse.self, from: data)
            let token = jsonResponse.token
            
            DispatchQueue.main.async {
                ProductAPI.shared.token = token ?? ""
            }
            
        } else {
            let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: data)
            throw APIError.registrationFailed(code: httpResponse.statusCode, message: errorResponse.message)
        }
    }
    
    
    enum APIError: Error {
        case invalidURL
        case invalidResponse
        case tokenNotFound
        case registrationFailed(code: Int, message: String)
    }
    
    struct ErrorResponse: Codable {
        let message: String
    }
}

