//
//  NetworkManager.swift
//  Sample_DogProject
//
//  Created by dattaz biradar on 16/03/26.
//

import Foundation

enum HTTPMethod: String {
    case GET, POST, PUT, DELETE
}

enum APIError: Error {
    case invalidURL
    case invalidResponse
    case serverError(Int)
    case decodingError
}


protocol APIClient {
    func request<T: Codable>(
        endpoint: String,
        method: HTTPMethod,
        queryItems: [URLQueryItem]?,
        body: Data?,
        responseType: T.Type
    ) async throws -> T
}

final class NetworkManagerService: APIClient {
    
    func request<T: Codable>(
        endpoint: String,
        method: HTTPMethod = .GET,
        queryItems: [URLQueryItem]? = nil,
        body: Data? = nil,
        responseType: T.Type
    ) async throws -> T {
        
        guard let baseURL = URL(string: "https://dogapi.dog/api/v2") else{
            throw APIError.invalidURL
        }

        let fullURL = baseURL.appendingPathComponent(endpoint)

        guard var components = URLComponents(url: fullURL, resolvingAgainstBaseURL: false) else {
            throw APIError.invalidURL
        }
        
        components.queryItems = queryItems
        
        guard let url = components.url else {
            throw APIError.invalidURL
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.httpBody = body
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.invalidResponse
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw APIError.serverError(httpResponse.statusCode)
        }
        
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw APIError.decodingError
        }
    }
}
