//
//  TextFieldsViews.swift
//  Sample_DogProject
//
//  Created by dattaz biradar on 16/03/26.
//

import SwiftUI

struct TextFieldsViews: View {
    let placeHolder   : String
    let isSecureField : Bool
    let label : String
    @Binding var text : String
    
    var body: some View {
        
        VStack(alignment: .leading){
            Text(label).font(.headline)
            inputFields
                .padding(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color.gray, lineWidth: 1)
                )
        }
        
    }

    @ViewBuilder
    private var inputFields: some View {
        if isSecureField {
            SecureField(placeHolder, text: $text)
        } else {
            TextField(placeHolder, text: $text)
        }
    }
}


#Preview {
    TextFieldsViews(placeHolder: "Name", isSecureField: false, label: "UserName", text: .constant(""))
        .padding()
}
