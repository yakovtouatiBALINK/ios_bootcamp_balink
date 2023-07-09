//
//  SearchView.swift
//  myFirstAppSwiftUI
//
//  Created by yacov touati on 06/07/2023.
//

import SwiftUI

struct SearchView: View {
    @StateObject var categoriesViewModel: CategoriesViewModel
//    @State private var searchText: String = ""
    
    var filteredProducts: [Product] {
            categoriesViewModel.searchTitle()
        }
    
    var body: some View {
        VStack {
            TextField("Search Title", text: $categoriesViewModel.searchText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            List(filteredProducts, id: \.id) { product in
                HStack(spacing: 16) {
                    VStack(alignment: .leading, spacing: 8) {
                        ProductViewModel.shared.createProductImage(product: product)
                        
                        Text(product.title)
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(Color(red: 0.0, green: 0.5, blue: 0.0))
                        
                        HStack {
                            Spacer()
                            Button(action: {
                                categoriesViewModel.toggleFavorite(for: product)
                            }) {
                                Image(systemName: categoriesViewModel.isFavorite(product) ? "star.fill" : "star")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 35, height: 35)
                                    .foregroundColor(.yellow)
                            }
                            .padding(.trailing, 3)
                        
                        
                        Text("$\(product.price)")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundColor(.green)
                        Spacer()
                        }
                    }
                }
            }
        }
        .onAppear {
            Task {
                await categoriesViewModel.fetchProducts()
            }
        }
    }
}

//struct SearchView_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchView()
//    }
//}
