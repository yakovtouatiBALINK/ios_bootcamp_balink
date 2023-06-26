//
//  Model.swift
//  my first IOS app BALINK
//
//  Created by yacov touati on 25/06/2023.
//

import Foundation

struct Product: Decodable {
    let id: Int?
    let title: String?
    let description: String?
    let price: Int?
    let discountPercentage: Double?
    let rating: Double?
    let stock: Int?
    let brand: String?
    let category: String?
    let thumbnail: String?
    let images: [String]?
}

