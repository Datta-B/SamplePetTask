//
//  BreedRepository.swift
//  Sample_DogProject
//
//  Created by dattaz biradar on 16/03/26.
//

import Foundation

protocol DogBreedRepository {
    func fetchBreeds() async throws -> DogBreedsResponse
}

protocol GroupRepository {
    func fetchGroups() async throws -> GroupResponse
}


class BreedRepositoryImpl : DogBreedRepository {
   
    private let service : APIClient
    init(service: APIClient = NetworkManagerService()) {
        self.service = service
    }
    
    func fetchBreeds() async throws -> DogBreedsResponse {
        return try await service.request(endpoint: "breeds",
                                                  method: .GET,
                                                  queryItems: nil,
                                                  body: nil,
                                                  responseType: DogBreedsResponse.self)
    }
}

class GroupRepositoryImpl : GroupRepository {
   
    private let service : APIClient
    
    init(service: APIClient = NetworkManagerService()) {
        self.service = service
    }
    
    func fetchGroups() async throws -> GroupResponse {
        return try await service.request(endpoint: "groups",
                                                  method: .GET,
                                                  queryItems: nil,
                                                  body: nil,
                                                  responseType: GroupResponse.self)
    }
    
}

