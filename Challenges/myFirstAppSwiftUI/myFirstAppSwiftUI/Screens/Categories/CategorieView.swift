//
//  CategorieView.swift
//  myFirstAppSwiftUI
//
//  Created by yacov touati on 28/06/2023.
//
import SwiftUI

struct ProductListView: View {
    @StateObject private var productViewModel = ProductViewModel()
//    @State private var categories: [String] = []
    
    var body: some View {
        VStack {
            if let error = productViewModel.error {
                Text("Error: \(error.localizedDescription)")
            } else if productViewModel.products.isEmpty {
                ProgressView()
            } else {
                List(productViewModel.categories, id: \.self) { category in
                    Text(category.capitalized)
                }
            }
        }
        .onAppear {
            Task {
                await productViewModel.fetchProducts()
              
            }
        }
    }
}

struct ProductListView_Previews: PreviewProvider {
    static var previews: some View {
        ProductListView()
    }
}
