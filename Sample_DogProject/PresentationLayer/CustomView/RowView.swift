//
//  RowView.swift
//  Sample_DogProject
//
//  Created by dattaz biradar on 17/03/26.
//

import SwiftUI

struct RowView: View {
    let name: String
    let image: Image
    
    var body: some View {
        HStack {
            image
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
                .padding()
            
            VStack(alignment: .leading) {
                Text(name)
                    .font(.headline)
            }
        }
    }
}

#Preview {
    RowView(name: "Breed", image: Image("dummyImage"))
}
