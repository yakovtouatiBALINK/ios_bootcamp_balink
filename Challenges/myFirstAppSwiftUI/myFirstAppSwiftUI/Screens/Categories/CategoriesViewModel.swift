//
//  CategoriesViewModel.swift
//  myFirstAppSwiftUI
//
//  Created by yacov touati on 02/07/2023.
//

import Foundation

class ProductViewModel: ObservableObject {
    @Published var products: [Product] = []
    @Published var error: Error?
    
    func fetchProducts() async {
        do {
            self.products = try await ProductAPI.shared.getProduct()
        } catch {
            self.error = error
        }
    }
    
    func getCategories(from products: [Product]) -> [String] {
        let categories = products.map { $0.category }
        return Array(Set(categories))
    }
}







