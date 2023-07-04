//
//  CategoriesViewModel.swift
//  myFirstAppSwiftUI
//
//  Created by yacov touati on 02/07/2023.
//

import Foundation

class CategoriesViewModel: ObservableObject {
    
    @Published var products: [Product] = []
    @Published var categories: [String] = []
    @Published var error: Error?
    
    func fetchProducts() async {
        Task {
            do {
                let fetchedProducts = try await ProductAPI.shared.getProduct()   // the singel api request
                DispatchQueue.main.async {
                    self.products = fetchedProducts          // update the array with all products that come from the api
                    self.categories = self.getCategories()   // update the array with all categories
                }
            } catch {
                DispatchQueue.main.async {
                    self.error = error
                }
            }
        }
    }
    
    func getCategories() -> [String] {
        var uniqueCategories: [String] = []
        for product in products {
            if !uniqueCategories.contains(product.category) {
                uniqueCategories.append(product.category)
            }
        }
        return uniqueCategories
    }
}

//func getValues<T: Hashable>(from products: [Product], propertyExtractor: (Product) -> T) -> [T] {
//    let values = products.map { propertyExtractor($0) }
//    return Array(Set(values))
//}
// let descriptions = getValues(from: products) { $0.description }
