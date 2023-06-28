//
//  CategorieView.swift
//  myFirstAppSwiftUI
//
//  Created by yacov touati on 28/06/2023.
//

import SwiftUI

struct CategorieView: View {
    var body: some View {
        VStack {
//                    Text("Title")
//                        .resizable()
//                        .aspectRatio(contentMode: .fit)
//                        .frame(height: 100)
                    
                    Text("categorys")
                        .font(.headline)
                        .foregroundColor(.primary)
                }
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .shadow(color: Color.gray.opacity(0.4), radius: 5, x: 0, y: 2)
            }
}


struct CategorieView_Previews: PreviewProvider {
    static var previews: some View {
        CategorieView()
    }
}
