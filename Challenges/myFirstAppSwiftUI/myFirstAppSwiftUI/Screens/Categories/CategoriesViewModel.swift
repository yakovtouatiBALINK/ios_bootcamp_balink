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
    
// func the get all rpoduct from the API and update yhe products array and categories array
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
    
    // func the get all categoty one time
    func getCategories() -> [String] {
        var uniqueCategories: [String] = []
        for product in products {
            if !uniqueCategories.contains(product.category) {
                uniqueCategories.append(product.category)
            }
        }
        self.categories = uniqueCategories
        return uniqueCategories
    }
    
    // func that response to add the productID to the favorites if is not exsiste and keep in the user default
    func toggleFavorite(for product: Product) {
        var fevoritesFromUD: [Int] = UserDefaults.standard.array(forKey: "FavoriteProductIDs") as? [Int] ?? []
        if fevoritesFromUD.contains(product.id) {
            fevoritesFromUD.removeAll(where:{ $0 == product.id })
        } else {
            fevoritesFromUD.append(product.id)
        }
        self.categories = self.getCategories()
        UserDefaults.standard.setValue(Array(fevoritesFromUD), forKey: "FavoriteProductIDs")
    }
    
    //func that return true if user default contain the productID
    func isFavorite(_ product: Product) -> Bool {
        let fevoritesFromUD: [Int] = UserDefaults.standard.array(forKey: "FavoriteProductIDs") as? [Int] ?? []
        return fevoritesFromUD.contains(product.id)
    }
    
    // func the return all fevorite prodocts
    func getFavoriteProducts() -> [Product] {
        let fevoritesFromUD: [Int] = UserDefaults.standard.array(forKey: "FavoriteProductIDs") as? [Int] ?? []
        return products.filter { fevoritesFromUD.contains($0.id) }
    }
    
    // func that return all product or that product for the search
    func searchTitle() -> [Product]{
        if searchText.isEmpty {
            return products
        } else {
            let searchLetters = searchText.lowercased()
            return products.filter { $0.title.lowercased().contains(searchLetters) || $0.brand.lowercased().contains(searchLetters) }
        }
    }
}
