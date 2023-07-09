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
    @Published var searchText: String = ""
    
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
        var uniqueCategories: [String] = []
        for product in products {
            if !uniqueCategories.contains(product.category) {
                uniqueCategories.append(product.category)
            }
        }
        return uniqueCategories
    }
    
    func toggleFavorite(for product: Product) {
        var fevoritesFromUD: [Int] = UserDefaults.standard.array(forKey: "FavoriteProductIDs") as? [Int] ?? []
        if fevoritesFromUD.contains(product.id) {
            fevoritesFromUD.removeAll(where:{ $0 == product.id })
            print(fevoritesFromUD)
        } else {
            fevoritesFromUD.append(product.id)
            print(fevoritesFromUD)
        }
        self.categories = self.getCategories()
        UserDefaults.standard.setValue(Array(fevoritesFromUD), forKey: "FavoriteProductIDs")
    }
    
    func isFavorite(_ product: Product) -> Bool {
        let arr: [Int] = UserDefaults.standard.array(forKey: "FavoriteProductIDs") as? [Int] ?? []
        return arr.contains(product.id)
    }
    
    func getFavoriteProducts() -> [Product] {
        let arr: [Int] = UserDefaults.standard.array(forKey: "FavoriteProductIDs") as? [Int] ?? []
        print(arr)
        return products.filter { arr.contains($0.id) }
    }
    
    func searchTitle() -> [Product]{
        if searchText.isEmpty {
            return products
        } else {
            let searchLetters = searchText.lowercased()
            return products.filter { $0.title.lowercased().contains(searchLetters) || $0.brand.lowercased().contains(searchLetters) }
        }
    }
}
