//
//  CategoriesViewModel.swift
//  myFirstAppSwiftUI
//
//  Created by yacov touati on 02/07/2023.
//

import Foundation

class ProductViewModel: ObservableObject {
    @Published var products: [Product] = []
    @Published var categories: [String] = []
    @Published var error: Error?
    
    func fetchProducts() async {
        Task {
            do {
                let fetchedProducts = try await ProductAPI.shared.getProduct()
                DispatchQueue.main.async {
                    self.products = fetchedProducts
                    self.categories = self.getCategories()
                }
            } catch {
                DispatchQueue.main.async {
                    self.error = error
                }
            }
        }
    }
    
    func getCategories() -> [String] {
        let categories = products.map { $0.category }
        return Array(Set(categories))
    }
}


//func getValues<T: Hashable>(from products: [Product], propertyExtractor: (Product) -> T) -> [T] {
//    let values = products.map { propertyExtractor($0) }
//    return Array(Set(values))
//}

