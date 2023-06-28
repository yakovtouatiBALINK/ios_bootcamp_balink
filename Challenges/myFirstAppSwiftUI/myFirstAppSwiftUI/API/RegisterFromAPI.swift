//
//  RegisterFromAPI.swift
//  myFirstAppSwiftUI
//
//  Created by yacov touati on 28/06/2023.
//

import Foundation

class UserAPI {
    static func createUser(firstname: String, lastname: String, username: String, password: String) async throws -> String {
        guard let url = URL(string: "https://balink.onlink.dev/users/register") else {
            throw APIError.invalidURL
        }
        
        let user = User(firstname: firstname, lastname: lastname, username: username, password: password)

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONEncoder().encode(user)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.invalidResponse
        }
        
        if httpResponse.statusCode == 200 {
            return try getToken(from: data)
        } else {
            let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: data)
            throw APIError.registrationFailed(code: httpResponse.statusCode, message: errorResponse.message)
        }
    }
    
    static func getToken(from data: Data) throws -> String {
        let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        guard let token = jsonResponse?["token"] as? String else {
            throw APIError.tokenNotFound
        }
        return token
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
