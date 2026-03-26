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
            HStack(spacing:12){
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 60, height: 60)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                
                Text(name)
                    .font(.headline)
                    .foregroundColor(.primary)
            }
            
            Spacer()
            
            Image(systemName: AppImages.chevronImage)
                .foregroundStyle(.tertiary)
        }
        .padding()
        .customShadow()
        .padding(.horizontal)
    }
}

#Preview {
    RowView(name: "Breed", image: Image(AppImages.dummyImage))
}
