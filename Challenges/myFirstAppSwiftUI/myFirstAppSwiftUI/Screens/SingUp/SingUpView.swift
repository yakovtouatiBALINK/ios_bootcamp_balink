//
//  RegistrationView.swift
//  myFirstAppSwiftUI
//
//  Created by yacov touati on 28/06/2023.
//

import SwiftUI

struct SingUpView: View {
    @StateObject private var signUp = SingUp()
    @State private var isRegistered = false
    
    var body: some View {
        VStack {
            Text("Sign Up")
                .font(.largeTitle)
                .padding()
            
            TextFieldView(title: "First Name", text: $signUp.firstname)
            TextFieldView(title: "Last Name", text: $signUp.lastname)
            TextFieldView(title: "User Name", text: $signUp.username)
            TextFieldView(title: "Password", text: $signUp.password)
            
            SignUpButton()
            NavigationLink(destination: CategoriesListView(), isActive: $isRegistered) {
                EmptyView()
            }
        }
        .padding()
    }
// func that when the user press the button to register is check if the registration is correct is allow to navigte in the next page
    func SignUpButton() -> some View {
        Button("Sign Up") {
            signUp.performRegistration { success in
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
