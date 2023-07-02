//
//  ProductAPI.swift
//  myFirstAppSwiftUI
//
//  Created by yacov touati on 02/07/2023.
//

import Foundation

struct ProductAPI {
    static var shared = ProductAPI()
    private let urlregis = "https://balink.onlink.dev/products"
    
    func getProduct(password: String) async throws -> [Product] {
        guard let token = UserDefaults.standard.string(forKey: "Token") else {
            throw APIError.tokenNotFound
        }
        
        guard let url = URL(string: urlregis) else {
            throw APIError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.invalidResponse
        }
        
        if httpResponse.statusCode == 201 {
            let products = try JSONDecoder().decode([Product].self, from: data)
            print(products)
            return products
        } else {
            let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: data)
            throw APIError.requestFailed(code: httpResponse.statusCode, message: errorResponse.message)
        }
    }
}
    
    
    
    
    
    
    
    
//    enum APIError: Error {
//        case invalidURL
//        case invalidResponse
//        case tokenNotFound
//        case registrationFailed(code: Int, message: String)
//    }
//
//    struct ErrorResponse: Codable {
//        let message: String
//    }
//

