//
//  ContentView.swift
//  myFirstAppSwiftUI
//
//  Created by yacov touati on 28/06/2023.
//
import SwiftUI

struct HomePageView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Welcome")
                    .font(.largeTitle)
                    .padding()
                
                NavigationLink(destination: SingUpView()) {
                    Text("Sing Up")
                        .font(.headline)
                        .padding()
                        .frame(width: 200, height: 50)
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                
                NavigationLink(destination: LoginView()) {
                    Text("Login")
                        .font(.headline)
                        .padding()
                        .frame(width: 200, height: 50)
                        .foregroundColor(.white)
                        .background(Color.orange)
                        .cornerRadius(10)
                }
                .padding()
            }
        }
    }
}

//    func loginButtonTapped() {
//        print("Login button tapped")
//    }

//    func signUpButtonTapped() {
//        print("Sign Up button tapped")
//    }
struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView()
    }
}
