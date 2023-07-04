//
//  ProductView.swift
//  myFirstAppSwiftUI
//
//  Created by yacov touati on 04/07/2023.
//

import SwiftUI

struct ProductView: View {
    @StateObject var categoriesViewModel: CategoriesViewModel
    @Binding var selectedCategory: String
    @State var products: [Product] = []
    
    var body: some View {
        List(products, id: \.id) { product in
            VStack(alignment: .leading) {
                Text(product.title)
                Text(product.description)
                Text(String(product.price))
            }
        }
        .onAppear {
            products = ProductViewModel.shared.getProductByCategory(category: selectedCategory, allProducts: categoriesViewModel.products)
        }
        .navigationTitle(selectedCategory.capitalized)
    }
}

//struct ProductView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProductView(productDetailsViewModel.products)
//    }
//}
