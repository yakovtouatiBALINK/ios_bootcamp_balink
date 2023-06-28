//
//  RegistrationView.swift
//  myFirstAppSwiftUI
//
//  Created by yacov touati on 28/06/2023.
//

import SwiftUI

struct SingUpView: View {
    @StateObject private var signUp = SignUp()
    
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var userName: String = ""
    @State private var password: String = ""
    
    var body: some View {
        VStack {
            Text("Registration")
                .font(.largeTitle)
                .padding()
            
            TextFieldView(title:"Last Name", text: $firstName)
            TextFieldView(title:"First Name", text: $lastName)
            TextFieldView(title:"User Name", text: $userName)
            TextFieldView(title:"Password", text: $password)

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

struct SingUpViewView_Previews: PreviewProvider {
    static var previews: some View {
        SingUpView()
    }
}
