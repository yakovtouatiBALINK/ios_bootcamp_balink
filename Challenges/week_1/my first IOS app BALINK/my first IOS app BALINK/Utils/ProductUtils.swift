//
//  ProductUtils.swift
//  my first IOS app BALINK
//
//  Created by yacov touati on 26/06/2023.
//

import Foundation

// class that handel all Product info
class ProductUtils {
    
    // function that get the token and return the data from the API
    static func fetchProductFromAPI(token: String) async throws -> [Product] {
        
        let url = URL(string: "https://balink.onlink.dev/products")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let (data, _) = try await URLSession.shared.data(for: request)
        let products = try JSONDecoder().decode([Product].self, from: data)
        
        print(String(data: data, encoding: .utf8) ?? "")
        return products
    }
}



// when i call this func i need this
//if let token = UserUtils.getToken() {
//    token = token
//} else {
//    print("Token not found")
//}



//do {
//    if let token = UserUtils.getToken() {
//        let products = try await ProductUtils.fetchProductFromAPI(token: token)
//        // Use the fetched products here
//        print(products)
//    } else {
//        print("Token not found")
//    }
//} catch {
//    print("Error: \(error)")
//}
