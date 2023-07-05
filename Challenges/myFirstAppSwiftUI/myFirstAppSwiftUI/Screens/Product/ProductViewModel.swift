//
//  ProductViewModel.swift
//  myFirstAppSwiftUI
//
//  Created by yacov touati on 04/07/2023.
//

import Foundation
import SwiftUI

class ProductViewModel: ObservableObject {
    static var shared = ProductViewModel()
    @Published var favorites: Set<Int> = []
    
    @Published var products: [Product] = []
    @Published var allProducts: [Product] = []
    
    func getProductByCategory(category: String, allProducts: [Product]) -> [Product] {
        return allProducts.filter { $0.category == category }
    }
    
    func createProductImage(product: Product) -> some View {
        if let firstImageURL = product.thumbnail, let imageURL = URL(string: firstImageURL) {
            return AnyView(
                AsyncImage(url: imageURL) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(12)
                } placeholder: {
                    Image(systemName: "photo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(12)
                }
            )
        } else {
            return AnyView(
                Image(systemName: "photo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(12)
            )
        }
    }
    
    func toggleFavorite(for product: Product) {
        if favorites.contains(product.id) {
            favorites.remove(product.id)
            print(favorites)
        } else {
            favorites.insert(product.id)
            print(favorites)
        }
    }
    
    func isFavorite(_ product: Product) -> Bool {
        favorites.contains(product.id)
    }
}

