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
            let firstName = jsonResponse.firstname
            let lastName = jsonResponse.lastname
            
            print(token ?? "")
            print(firstName ?? "")
            print(lastName ?? "")
            
            DispatchQueue.main.async {
                ProductAPI.shared.token = token
            }
            
            print("First Name: \(firstName ?? "")")
            print("Last Name: \(lastName ?? "")")
            print("Token: \(token ?? "")")
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



//        func getProduct() async throws -> [Product] {
//            guard let token = UserDefaults.standard.string(forKey: "Token") else {
//                throw APIError.tokenNotFound
//            }
//
//            guard let url = URL(string: "https://balink.onlink.dev/register") else {
//                throw APIError.invalidURL
//            }
//
//            var request = URLRequest(url: url)
//            request.httpMethod = "GET"
//            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//            request.addValue("application/json", forHTTPHeaderField: "Accept")
//            request.addValue(token, forHTTPHeaderField: "Authorization")
//
//            let (data, response) = try await URLSession.shared.data(for: request)
//            if let res = response as? HTTPURLResponse,
//               res.statusCode == 200 {
//                let products = try JSONDecoder().decode([Product].self, from: data)
//                print(products)
//                return products
//            }  else {
//                throw APIError.invalidResponse
//            }
//        }
