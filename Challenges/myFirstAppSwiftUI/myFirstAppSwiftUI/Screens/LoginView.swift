//
//  SingUpView.swift
//  myFirstAppSwiftUI
//
//  Created by yacov touati on 28/06/2023.
//

import SwiftUI

struct LoginView: View {
    
    @State private var userName: String = ""
    @State private var password: String = ""
    
    var body: some View {
        VStack {
            Text("Login")
                .font(.largeTitle)
                .padding()
            
            TextFieldView(title:"User Name", text: $userName)
            TextFieldView(title:"password", text: $password)
            
            NavigationLink(destination: CategorieView()) {
                Text("Show Categories")
                    .font(.headline)
                    .padding()
                    .frame(width: 200, height: 50)
                    .foregroundColor(.white)
                    .background(Color.green)
                    .cornerRadius(10)
            }
            .padding()
        }
        .padding()
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
