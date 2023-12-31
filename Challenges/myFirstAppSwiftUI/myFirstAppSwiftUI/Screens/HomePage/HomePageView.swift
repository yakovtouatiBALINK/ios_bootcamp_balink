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
                    HomePageButton("Sign Up", color: .green.opacity(0.8))
                }
//                NavigationLink(destination: CategoriesListView()) {
                NavigationLink(destination: LoginView()) {
                    HomePageButton("Login", color: .green.opacity(0.8))
                }
                .padding()
            }
        }
    }
    
    //func that create the button on the view
    func HomePageButton(_ title: String, color: Color) -> some View {
        Text(title)
            .font(.headline)
            .padding()
            .frame(width: 200, height: 50)
            .foregroundColor(.white)
            .background(color)
            .cornerRadius(10)
    }
}
