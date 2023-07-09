//
//  SingUpView.swift
//  myFirstAppSwiftUI
//
//  Created by yacov touati on 28/06/2023.
//

import SwiftUI

struct LoginView: View {
    @StateObject private var loginViewModel = LoginViewModel()
    @State private var isRegistered = false
    
    var body: some View {
        VStack {
            Text("Login")
                .font(.largeTitle)
                .padding()
            
            TextFieldView(title: "User Name", text: $loginViewModel.username)
            TextFieldView(title: "Password", text: $loginViewModel.password)
            
            SignUpButton()
            NavigationLink(destination: CategoriesListView(), isActive: $isRegistered) {
                EmptyView()
            }
        }
        .padding()
    }
    
    func SignUpButton() -> some View {
        Button("Sign Up") {
            loginViewModel.performRegistration { success in
                isRegistered = success
            }
        }
        .font(.headline)
        .padding()
        .frame(width: 200, height: 50)
        .foregroundColor(.white)
        .background(Color.green)
        .cornerRadius(10)
    }
}

