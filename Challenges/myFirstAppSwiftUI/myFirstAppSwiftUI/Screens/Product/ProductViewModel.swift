//
//  ProductViewModel.swift
//  myFirstAppSwiftUI
//
//  Created by yacov touati on 04/07/2023.
//

import Foundation

class ProductViewModel: ObservableObject {
    static var shared = ProductViewModel()
    
    @Published var products: [Product] = []
    @Published var allProducts: [Product] = []
    
    func getProductByCategory(category: String, allProducts: [Product]) -> [Product] {
        return allProducts.filter { $0.category == category }
    }
}

