//
//  Product.swift
//  myFirstAppSwiftUI
//
//  Created by yacov touati on 02/07/2023.
//

import Foundation

struct Product: Codable, Identifiable {
    let id: Int
    let title, description: String
    let price: Int
    let discountPercentage, rating: Double
    let stock: Int
    let brand, category: String
    let thumbnail: String
    let images: [String]
}
