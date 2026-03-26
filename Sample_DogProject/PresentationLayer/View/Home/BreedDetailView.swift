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
                breedImageView
                Text(breed.attributes.name)
                    .font(.title)
                    .fontWeight(.bold)
                
                BreedInfoSection(breed: breed)
                
                BreedDescriptionSection(description: breed.attributes.description)
            }
            .padding(.vertical)
        }
        .toolbar(.hidden, for: .tabBar)
        .navigationTitle(BreedStrings.breedDetailsTitle)
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - Subviews 

private var breedImageView: some View {
    Image(AppImages.dogImage)
        .resizable()
        .scaledToFill()
        .frame(height: 250)
        .frame(maxWidth: .infinity)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: .black.opacity(0.2), radius: 10, y: 5)
        .padding(.horizontal)
}

private struct BreedInfoRow: View {
    let title: String
    let value: String
    
    var body: some View {
        HStack {
            Text(title).fontWeight(.semibold)
            Spacer()
            Text(value).foregroundColor(.secondary)
        }
    }
}

private struct BreedInfoSection: View {
    let breed: Breed
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            BreedInfoRow(
                title: BreedStrings.lifeSpan,
                value: "\(breed.attributes.life.min) - \(breed.attributes.life.max) \(BreedStrings.years)"
            )

            BreedInfoRow(
                title: BreedStrings.maleWeight,
                value: "\(breed.attributes.maleWeight.min) - \(breed.attributes.maleWeight.max) \(BreedStrings.kg)"
            )

            BreedInfoRow(
                title: BreedStrings.femaleWeight,
                value: "\(breed.attributes.femaleWeight.min) - \(breed.attributes.femaleWeight.max) \(BreedStrings.kg)"
            )

            BreedInfoRow(
                title: BreedStrings.hypoallergenic,
                value: breed.attributes.hypoallergenic ? BreedStrings.yes : BreedStrings.no
            )

            BreedInfoRow(
                title: BreedStrings.groupId,
                value: breed.relationships.group.data.id
            )

            Text(BreedStrings.aboutBreed)
                .font(.headline)
        }
        .padding()
        .customShadow()
        .padding(.horizontal)
    }
}

private struct BreedDescriptionSection: View {
    let description: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(BreedStrings.aboutBreed)
                .font(.headline)
            Text(description)
                .font(.body)
                .foregroundColor(.secondary)
        }
        .padding()
        .customShadow()
        .padding(.horizontal)
    }
}

#Preview {
    BreedDetailView(breed: .mock)
}


