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
    
    var token: String?
    
    func getProduct() async throws -> [Product] {
        //        guard let tokenData = UserDefaults.standard.data(forKey: "Token"),
        //              let tokenString = String(data: tokenData, encoding: .utf8) else {
        //            throw APIError.tokenNotFound
        //        }
        
        //let token = tokenString.replacingOccurrences(of: #"\"#, with: "")
        
        guard let url = URL(string: urlregis) else {
            throw APIError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        if let token = token {
            request.addValue(token, forHTTPHeaderField: "Authorization")
        }
        
        let (data, response) = try await URLSession.shared.data(for: request)
        if let res = response as? HTTPURLResponse,
           res.statusCode == 200{
            let products = try JSONDecoder().decode([Product].self, from: data)
            print(products)
            return products
        }  else {
            throw APIError.invalidResponse
        }
        
        
        //         else {
        //            let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: data)
        //            throw APIError.requestFailed(code: httpResponse.statusCode, message: errorResponse.message)
        //        }
    }
}


