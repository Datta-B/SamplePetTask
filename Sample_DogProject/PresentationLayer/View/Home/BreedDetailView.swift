//
//  BreedDetailView.swift
//  Sample_DogProject
//
//  Created by dattaz biradar on 16/03/26.
//

import SwiftUI

struct BreedDetailView: View {
    let breed: Breed
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Image("dogPic")
                    .resizable()
                    .scaledToFill()
                    .frame(height: 250)
                    .frame(maxWidth: .infinity)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .shadow(color: .black.opacity(0.2), radius: 10, y: 5)
                    .padding(.horizontal)
                
                
                Text(breed.attributes.name)
                    .font(.title)
                    .fontWeight(.bold)
                
                
                VStack(alignment: .leading, spacing: 15) {
                    
                    infoRow(title: "Life Span",
                            value: "\(breed.attributes.life.min) - \(breed.attributes.life.max) years")
                    
                    infoRow(title: "Male Weight",
                            value: "\(breed.attributes.maleWeight.min) - \(breed.attributes.maleWeight.max) kg")
                    
                    infoRow(title: "Female Weight",
                            value: "\(breed.attributes.femaleWeight.min) - \(breed.attributes.femaleWeight.max) kg")
                    
                    infoRow(title: "Hypoallergenic",
                            value: breed.attributes.hypoallergenic ? "Yes" : "No")
                    
                    infoRow(title: "Group ID",
                            value: breed.relationships.group.data.id)
                    
                }
                .padding()
                .customShadow()
                .padding(.horizontal)
                
                VStack(alignment: .leading, spacing: 10) {
                    
                    Text("About Breed")
                        .font(.headline)
                    
                    Text(breed.attributes.description)
                        .font(.body)
                        .foregroundColor(.secondary)
                    
                }
                .padding()
                .customShadow()
                .padding(.horizontal)
                
            }
            .padding(.vertical)
        }
        .toolbar(.hidden, for: .tabBar)
        .navigationTitle("Breed Details")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    
    // Reusable Row
      private func infoRow(title: String, value: String) -> some View {
          
          HStack {
              Text(title)
                  .fontWeight(.semibold)
              
              Spacer()
              
              Text(value)
                  .foregroundColor(.secondary)
          }
      }
  }

#Preview {
    BreedDetailView(breed: .mock)
}

//


