//
//  MockApiClinet.swift
//  Sample_DogProject
//
//  Created by dattaz biradar on 17/03/26.
//

import Foundation

final class MockAPIClient: APIClient {
    var resultData: Data?
    var shouldThrowError: Bool = false
    var errorToThrow: Error = NSError(domain: "TestError", code: -1)
    
    func request<T>(
        endpoint: String,
        method: HTTPMethod,
        queryItems: [URLQueryItem]?,
        body: Data?,
        responseType: T.Type
    ) async throws -> T where T: Decodable {
        
        if shouldThrowError {
            throw errorToThrow
        }
        
        guard let data = resultData else {
            throw NSError(domain: "NoMockData", code: -1)
        }
        
        let decoded = try JSONDecoder().decode(T.self, from: data)
        return decoded
    }
}
