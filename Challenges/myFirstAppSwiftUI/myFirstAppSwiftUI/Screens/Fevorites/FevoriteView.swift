//
//  FevoriteView.swift
//  myFirstAppSwiftUI
//
//  Created by yacov touati on 05/07/2023.
//

import SwiftUI

struct FevoriteView: View {
    
    @StateObject var categoriesViewModel: CategoriesViewModel
//    @EnvironmentObject var productVM: AllProducts
    
    var body: some View {
        List(categoriesViewModel.getFavoriteProducts(), id: \.id) { product in
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
}







//struct FevoriteView_Previews: PreviewProvider {
//    static var previews: some View {
//        FevoriteView()
//    }
//}
