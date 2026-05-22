//
//  MockApiClinet.swift
//  Sample_DogProject
//
//  Created by dattaz biradar on 17/03/26.
//

import Foundation

enum MockAPIResponse {
    case success(Data)
    case failure(Error)
}
@MainActor
final class MockAPIClient: APIClient {
    
    var response: MockAPIResponse?
    
    func request<T>(
        endpoint: APIEndpoint,
        responseType: T.Type
    ) async throws -> T where T: Decodable, T: Encodable {
        
        guard let response else {
            throw NSError(domain: "NoMockResponse", code: -1)
        }
        
        switch response {
        case .success(let data):
            return try JSONDecoder().decode(T.self, from: data)
            
        case .failure(let error):
            throw error
        }
    }
    
}
