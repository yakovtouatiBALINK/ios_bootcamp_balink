//
//  allProductsViewModel.swift
//  myFirstAppSwiftUI
//
//  Created by yacov touati on 08/07/2023.
//

import Foundation

class AllProducts {
    static var products: [Product] = []
    static var error: Error?
    
    func fetchProducts() async {
        Task {
            do {
                let fetchedProducts = try await ProductAPI.shared.getProduct()
                DispatchQueue.main.async {
                    AllProducts.products = fetchedProducts
                }
            } catch {
                DispatchQueue.main.async {
                    AllProducts.error = error
                }
            }
        }
    }
}
