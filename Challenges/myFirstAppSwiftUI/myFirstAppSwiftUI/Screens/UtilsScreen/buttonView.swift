//
//  buttonView.swift
//  myFirstAppSwiftUI
//
//  Created by yacov touati on 02/07/2023.
//

import SwiftUI


// MARK: complet this
struct ButtonView: View {
    
    var title: String = ""
    @Binding var text: String
    
    var body: some View {
        TextField(title, text: $text )
        
        Text("Show Categories")
            .font(.headline)
            .padding()
            .frame(width: 200, height: 50)
            .foregroundColor(.white)
            .background(Color.green)
            .cornerRadius(10)
    }
}

struct ButtonView_Previews: PreviewProvider {
    @State static var text: String = ""
    static var previews: some View {
        TextFieldView(title: "Last Name", text: $text )
    }
}
