//
//  FevoriteView.swift
//  myFirstAppSwiftUI
//
//  Created by yacov touati on 05/07/2023.
//

import SwiftUI

struct FevoriteView: View {
    @StateObject var categoriesViewModel: CategoriesViewModel
    
    var body: some View {
        List(categoriesViewModel.getFavoriteProducts(), id: \.id) { product in
            Text(product.title)
        }
    }
}







//struct FevoriteView_Previews: PreviewProvider {
//    static var previews: some View {
//        FevoriteView()
//    }
//}
