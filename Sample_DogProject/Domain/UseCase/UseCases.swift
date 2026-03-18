//
//  UseCases.swift
//  Sample_DogProject
//
//  Created by dattaz biradar on 16/03/26.
//

import Foundation

protocol GetDogBreedsUseCaseProtocol {
    func execute() async throws -> DogBreedsResponse
}

final class GetDogBreedsUseCase : GetDogBreedsUseCaseProtocol  {

    private let repository: DogBreedRepository

    init(repository: DogBreedRepository) {
        self.repository = repository
    }

    func execute() async throws -> DogBreedsResponse {
        try await repository.fetchBreeds()
    }
}


protocol GetGroupUseCaseProtocol {
    func execute() async throws -> GroupResponse
}

final class GetGroupUseCase : GetGroupUseCaseProtocol  {
    private let repository: GroupRepository

    init(repository: GroupRepository) {
        self.repository = repository
    }

    func execute() async throws -> GroupResponse {
        try await repository.fetchGroups()
    }
}
