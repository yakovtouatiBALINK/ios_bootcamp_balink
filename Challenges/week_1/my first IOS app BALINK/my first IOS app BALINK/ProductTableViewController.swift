//
//  ProductTableViewController.swift
//  my first IOS app BALINK
//
//  Created by yacov touati on 22/06/2023.
//

import UIKit

class ProductTableViewController: UITableViewController {
    struct Product: Decodable {
        let id: Int?
        let title: String?
        let description: String?
        let price: Int?
        let discountPercentage: Double?
        let rating: Double?
        let stock: Int?
        let brand: String?
        let category: String?
        let thumbnail: String?
        let images: [String]?
    }
    
//    override func viewDidLoad() async {
//        super.viewDidLoad()
//
//        await fetchProductFromAPI()
//
//    }
    
    func fetchProductFromAPI() async throws  -> [Product]{
        
        let url = URL(string: "https://balink.onlink.dev/products")!
        var token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6ImZoZGpqZmZqQGZmZy50dGciLCJwYXNzd29yZCI6ImZkaGZqIiwiaWF0IjoxNjg3NDQ3NjAzfQ.yuld-SHMjajF2ZhCFJiGGkOUN3DXnbQ1_KH2NcfDLoM"
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let (data, _) = try await URLSession.shared.data(for: request)
        let decoded = try JSONDecoder().decode([Product].self, from: data)
        
        print(String(data: data, encoding: .utf8) ?? "")
        return decoded
    }
    
//    Task {
//        do {
//            let product = try await fetchProductFromAPI()
//            print(product)
//        } catch {
//            print(error)
//        }
//    }
    
}


