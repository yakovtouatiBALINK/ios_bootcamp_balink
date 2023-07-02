//
//  RegistrationView.swift
//  myFirstAppSwiftUI
//
//  Created by yacov touati on 28/06/2023.
//

import SwiftUI

struct SingUpView: View {
    @StateObject private var signUp = SingUp()
    //    @State private var isRegistered = false
    
    var body: some View {
        VStack {
            Text("Sing Up")
                .font(.largeTitle)
                .padding()
            
            TextFieldView(title: "First Name", text: $signUp.firstname)
            TextFieldView(title: "Last Name", text: $signUp.lastname)
            TextFieldView(title: "User Name", text: $signUp.username)
            TextFieldView(title: "Password", text: $signUp.password)
            
            
            Button("sinjj", action: action)
            
            
            //            Button(action: {
            //                Task {
            //                    do {
            //                        try await signUp.registerUser()
            ////                        isRegistered = true
            //                    } catch {
            //                        print("Registration error: \(error)")
            //                    }
            //                }
            //            }) {
            ////                if isRegistered {
            //                    NavigationLink(destination: CategorieView()) {
            //                        Text("Show Categories")
            //                            .font(.headline)
            //                            .padding()
            //                            .frame(width: 200, height: 50)
            //                            .foregroundColor(.white)
            //                            .background(Color.green)
            //                            .cornerRadius(10)
            //                    }
            //                    .padding()
            //                }
            //            }
                .padding()
        }
    }
    func action (){
        Task {
            do {
                try await signUp.registerUser()
                //                        isRegistered = true
            } catch {
                print("Registration error: \(error)")
            }
            
        }
    }
}
    
    struct SingUpViewView_Previews: PreviewProvider {
        static var previews: some View {
            SingUpView()
        }
    }
