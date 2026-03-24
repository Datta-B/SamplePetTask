//
//  Endpoint.swift
//  Sample_DogProject
//
//  Created by dattaz biradar on 24/03/26.
//

import Foundation

enum HTTPMethod: String {
    case GET, POST, PUT, DELETE
}

enum APIError: Error {
    case invalidURL
    case invalidRequest
    case requestFailed(Error)
    case invalidResponse
    case serverError(Int)
    case decodingError(Error)
    case cancelled
}

protocol EndpointProtocol {
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var queryItems: [URLQueryItem]? { get }
    var headers: [String: String]? { get }
    var body: Data? { get }
}

struct APIEndpoint: EndpointProtocol {
    let baseURL: String
    let path: String
    let method: HTTPMethod
    let queryItems: [URLQueryItem]?
    let headers: [String: String]?
    let body: Data?
    
    init(baseURL: String = APIConfig.baseURL,
         path: String,
         method: HTTPMethod,
         queryItems: [URLQueryItem]? = nil,
         headers: [String: String]? = nil,
         body: Data? = nil) {
        self.baseURL = baseURL
        self.path = path
        self.method = method
        self.queryItems = queryItems
        self.headers = headers
        self.body = body
    }
}

struct APIConfig {
    static let baseURL = "https://dogapi.dog/api/v2"
}

struct DogBreedEndpoint {
    static var getBreedList : APIEndpoint {
        return APIEndpoint(path: "breeds", method: .GET)
    }
}

struct GroupEndpoint {
    static var getGroupList : APIEndpoint {
        return APIEndpoint(path: "groups", method: .GET)
    }
}
