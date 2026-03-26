//
//  MockUseCases.swift
//  Sample_DogProject
//
//  Created by dattaz biradar on 26/03/26.
//

import Foundation

/// For Breed
 class MockBreedUseCase: GetDogBreedsUseCaseProtocol {
    func execute() async throws -> DogBreedsResponse {
        return DogBreedsResponse(data: [Breed.mock])
    }
}

/// For Groups
class MockGroupUseCase : GetGroupUseCaseProtocol {
    func execute() async throws -> GroupResponse {
        return GroupResponse(data: [Group.mock])
    }
}
