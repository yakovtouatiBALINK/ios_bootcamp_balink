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
                    createProductImage(product: product)
                    
                    
                    Text(product.title)
                        .font(.title)
                        .fontWeight(.bold)
                    
                    createDescriptionView(product: product, isShowingDescription: $isShowingDescription)
                    
                    Text("thumbnail")
                        .font(.title3)
                        .fontWeight(.bold)
                    Text(product.thumbnail)
                        .font(.body)
                        .foregroundColor(.gray)
                    
                    Text("$\(product.price)")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundColor(.green)
                    
                }
            }
            .padding(.vertical, 16)
        }
        .onAppear {
            products = ProductViewModel.shared.getProductByCategory(category: selectedCategory, allProducts: categoriesViewModel.products)
        }
        .navigationTitle(selectedCategory.capitalized)
    }
}

extension ProductView {
    func createProductImage(product: Product) -> some View {
        if let firstImageURL = product.images.first, let imageURL = URL(string: firstImageURL) {
            return AnyView(
                AsyncImage(url: imageURL) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(12)
                } placeholder: {
                    Image(systemName: "photo") // Placeholder image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(12)
                }
            )
        } else {
            return AnyView(
                Image(systemName: "photo") // Placeholder image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(12)
            )
        }
    }
    
    
    func createDescriptionView(product: Product, isShowingDescription: Binding<Bool>) -> some View {
        return Text("Description:")
            .font(.title3)
            .fontWeight(.bold)
            .foregroundColor(.blue)
            .padding(.vertical, 8)
            .padding(.horizontal, 12)
            .background(
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.blue, lineWidth: 2)
                        .background(Color.white)
                }
            )
            .onTapGesture {
                isShowingDescription.wrappedValue = true
            }
            .alert(isPresented: Binding<Bool>(
                get: { isShowingDescription.wrappedValue && selectedProduct?.id == product.id },
                set: { _ in }
            )) {
                Alert(
                    title: Text("תיאור"),
                    message: Text(product.description),
                    dismissButton: .default(Text("סגור")) {
                        isShowingDescription.wrappedValue = false
                    }
                )
            }
    }
}










//struct ProductView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProductView(productDetailsViewModel.products)
//    }
//}
