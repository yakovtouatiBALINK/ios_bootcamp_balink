//
//  CategoriesViewModel.swift
//  myFirstAppSwiftUI
//
//  Created by yacov touati on 02/07/2023.
//

import Foundation
import SwiftUI

class CategoriesViewModel: ObservableObject {
    @Published var products: [Product] = []
    @Published var categories: [String] = []
    @Published var error: Error?
    @Published private var favorites: Set<Int> = []
    
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
    
    func toggleFavorite(for product: Product) {
        if favorites.contains(product.id) {
            favorites.remove(product.id)
            print(favorites)
        } else {
            favorites.insert(product.id)
            print(favorites)
        }
        
        saveFavoritesToUserDefaults()
    }
    
    func isFavorite(_ product: Product) -> Bool {
        return favorites.contains(product.id)
    }
    
    private func saveFavoritesToUserDefaults() {
        UserDefaults.standard.setValue(Array(favorites), forKey: "FavoriteProductIDs")
    }
    
    func getFavoriteProducts() -> [Product] {
        return products.filter { favorites.contains($0.id) }
    }
}
