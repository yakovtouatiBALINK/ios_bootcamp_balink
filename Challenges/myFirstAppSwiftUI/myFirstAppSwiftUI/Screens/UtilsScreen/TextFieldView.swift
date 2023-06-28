//
//  Text.swift
//  myFirstAppSwiftUI
//
//  Created by yacov touati on 28/06/2023.
//

import SwiftUI

struct TextFieldView: View {
    
    var title: String = ""
    @Binding var text: String
    
    var body: some View {
        TextField(title, text: $text )
            .padding()
            .background(.yellow.opacity(0.5))
            .cornerRadius(10)
    }
}

struct TextFieldView_Previews: PreviewProvider {
    @State static var text: String = ""
    static var previews: some View {
        TextFieldView(title: "Last Name", text: $text )
    }
}
