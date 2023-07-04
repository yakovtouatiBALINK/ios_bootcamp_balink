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
                
                Button("Sign Up", action: action)
                    .font(.headline)
                    .padding()
                    .frame(width: 200, height: 50)
                    .foregroundColor(.white)
                    .background(Color.green)
                    .cornerRadius(10)
                NavigationLink(destination: ProductListView(), isActive: $isRegistered) {
                    EmptyView()
                }
            }
            .padding()
    }
    func action() {
        Task {
            do {
                try await loginViewModel.loginUser()
                isRegistered = true
            } catch {
                print("Registration error: \(error)")
            }
        }
    }
}


struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
