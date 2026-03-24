//
//  NetworkManager.swift
//  Sample_DogProject
//
//  Created by dattaz biradar on 16/03/26.
//

import Foundation


/// For URLBuilding
protocol URLBuilding {
    func build(base:String,endPoint:String,queryItem : [URLQueryItem]?) throws -> URL
}

class URLBuilder : URLBuilding {
    func build(base: String, endPoint: String, queryItem: [URLQueryItem]?) throws -> URL {
        guard let baseURL = URL(string: base) else {throw APIError.invalidURL}
        var components = URLComponents(url: baseURL.appending(path: endPoint), resolvingAgainstBaseURL: false)
        components?.queryItems = queryItem
        guard let url = components?.url else{throw APIError.invalidURL}
        return url
    }
    
}

/// For URL Request
protocol URLRequestBuilder {
    func makeRequest(url:URL,method:HTTPMethod,body:Data?) -> URLRequest
}

class RequestBuilder : URLRequestBuilder {
    func makeRequest(url: URL, method: HTTPMethod, body: Data?) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.httpBody = body
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        return request
    }
}


/// for validating Reponse
protocol ResponseValidaing {
    func validate(response : URLResponse) throws -> HTTPURLResponse
}

class ValidateRequest : ResponseValidaing {
    func validate(response: URLResponse) throws -> HTTPURLResponse {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.invalidResponse
        }

        guard (200...299).contains(httpResponse.statusCode) else {
            throw APIError.serverError(httpResponse.statusCode)
        }
        return httpResponse
    }
}


/// for mapping the data
protocol Decoding {
    func decode<T:Codable>(responseType:T.Type,data:Data) throws -> T
}

class JSONDecoderService : Decoding {
    func decode<T>(responseType: T.Type, data: Data) throws -> T where T : Decodable, T : Encodable {
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw APIError.decodingError(error)
        }
    }
    
}


protocol APIClient {
    func request<T: Codable>(
        endpoint: APIEndpoint,
        responseType: T.Type
    ) async throws -> T
}


final class NetworkManagerService: APIClient {
    
    private let urlBuilder: URLBuilding
    private let requestBuilder: RequestBuilder
    private let responseValidator: ResponseValidaing
    private let decoder: Decoding
    
    init(
        urlBuilder: URLBuilding = URLBuilder(),
        requestBuilder: RequestBuilder = RequestBuilder(),
        responseValidator: ResponseValidaing = ValidateRequest(),
        decoder: Decoding = JSONDecoderService()
    ) {
        self.urlBuilder = urlBuilder
        self.requestBuilder = requestBuilder
        self.responseValidator = responseValidator
        self.decoder = decoder
    }
    
    func request<T>(endpoint: APIEndpoint, responseType: T.Type) async throws -> T where T : Decodable, T : Encodable {
        do{
            // for url
            let url = try urlBuilder.build(base: endpoint.baseURL, endPoint: endpoint.path, queryItem: endpoint.queryItems)
            // for request
            let request = requestBuilder.makeRequest(url: url, method: endpoint.method, body: endpoint.body)
            
            let (data, response) = try await URLSession.shared.data(for: request)
            _ = try responseValidator.validate(response: response)
            return try decoder.decode(responseType: T.self, data: data)
            
        }catch{
            throw error
        }

    }
}
