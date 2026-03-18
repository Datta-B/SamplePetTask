//
//  Entities.swift
//  Sample_DogProject
//
//  Created by dattaz biradar on 16/03/26.
//

import Foundation

// For Breeds
struct DogBreedsResponse: Codable {
    let data: [Breed]
}

struct Breed: Codable,Identifiable,Hashable {
    let id: String
    let type: String
    let attributes: BreedAttributes
    let relationships: BreedRelationships
}

struct BreedAttributes: Codable,Hashable {
    let name: String
    let description: String
    let life: Life
    let maleWeight: Weight
    let femaleWeight: Weight
    let hypoallergenic: Bool
    
    enum CodingKeys: String, CodingKey {
        case name
        case description
        case life
        case maleWeight = "male_weight"
        case femaleWeight = "female_weight"
        case hypoallergenic
    }
}

struct Life: Codable,Hashable {
    let max: Int
    let min: Int
}

struct Weight: Codable,Hashable {
    let max: Int
    let min: Int
}

struct BreedRelationships: Codable,Hashable {
    let group: GroupRelationship
}

struct GroupRelationship: Codable,Hashable {
    let data: GroupData
}

struct GroupData: Codable,Identifiable,Hashable {
    let id: String
    let type: String
}


 /// For Groups

struct GroupResponse: Codable {
    let data: [Group]
}

struct Group: Codable,Identifiable {
    let id: String
    let type: String
    let attributes: GroupAttributes
    let relationships: GroupRelationships
}

struct GroupAttributes: Codable {
    let name: String
}

struct GroupRelationships: Codable {
    let breeds: BreedsRelationship
}

struct BreedsRelationship: Codable {
    let data: [BreedReference]
}

struct BreedReference: Codable {
    let id: String
    let type: String
}


extension Breed {
    static let mock = Breed(
        id: "036feed0-da8a-42c9-ab9a-57449b530b13",
        type: "breed",
        attributes: BreedAttributes(
            name: "Affenpinscher",
            description: "The Affenpinscher is a small and playful breed originally bred in Germany.",
            life: Life(max: 16, min: 14),
            maleWeight: Weight(max: 5, min: 3),
            femaleWeight: Weight(max: 5, min: 3),
            hypoallergenic: true
        ),
        relationships: BreedRelationships(
            group: GroupRelationship(
                data: GroupData(
                    id: "f56dc4b1-ba1a-4454-8ce2-bd5d41404a0c",
                    type: "group"
                )
            )
        )
    )
    
}

extension Group {
    static let mock = Group(
        id: "8000793f-a1ae-4ec4-8d55-ef83f1f644e5",
        type: "group",
        attributes: GroupAttributes(
            name: "Foundation Stock Service"
        ),
        relationships: GroupRelationships(
            breeds: BreedsRelationship(
                data: [
                    BreedReference(
                        id: "68f47c5a-5115-47cd-9849-e45d3c378f12",
                        type: "breed"
                    )
                ]
            )
        )
    )
}
