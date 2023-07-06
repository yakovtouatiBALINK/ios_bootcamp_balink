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
    @State private var isShowingDescription = false
    @State private var selectedProduct: Product? = nil
    
    var body: some View {
        List(products, id: \.id) { product in
            HStack(spacing: 16) {
                VStack(alignment: .leading, spacing: 8) {
                    ProductViewModel.shared.createProductImage(product: product)
                    
                    Text(product.title)
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(Color(red: 0.0, green: 0.5, blue: 0.0))
                    
                    createDescriptionView(for: product)
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
                    }
                    
                    Text("$\(product.price)")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundColor(.green)
                    Spacer()
                }
            }
            .padding(.vertical, 16)
        }
        .onAppear {
            products = ProductViewModel.shared.getProductByCategory(category: selectedCategory, allProducts: categoriesViewModel.products)
        }
        .navigationTitle(selectedCategory.capitalized)
    }
    
    func createDescriptionView(for product: Product) -> some View {
        return Text("Description")
            .font(.title3)
            .fontWeight(.bold)
            .foregroundColor(.blue)
            .padding(.vertical, 8)
            .padding(.horizontal, 12)
            .background(
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.green.opacity(0.8), lineWidth: 2)
                        .background(Color.white)
                }
            )
            .onTapGesture {
                selectedProduct = product
                isShowingDescription = true
            }
            .alert(isPresented: $isShowingDescription) {
                Alert(
                    title: Text("Description"),
                    message: Text(selectedProduct?.description ?? ""),
                    dismissButton: .default(Text("close"))
                )
            }
    }
}
