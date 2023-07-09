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
//    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6IndlYWZnQGZmLmdoIiwicGFzc3dvcmQiOiJlcmQiLCJpYXQiOjE2ODc0MjQ0MTR9.UwfOEkXGAHHZY0VmwNiUXNIVJQmVsRWMcfxGNrOZLaw"
    
    
    func getProduct() async throws -> [Product] {
        guard let url = URL(string: urlregis) else {
            throw APIError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
//        request.addValue(token, forHTTPHeaderField: "Authorization")
        if let token = token {
            request.addValue(token, forHTTPHeaderField: "Authorization")
        }
        
        let (data, response) = try await URLSession.shared.data(for: request)
        if let res = response as? HTTPURLResponse,
           res.statusCode == 200 {
            let products = try JSONDecoder().decode([Product].self, from: data)
            return products
        }  else {
            throw APIError.invalidResponse
        }
    }
}


