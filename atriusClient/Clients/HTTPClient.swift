//
//  HTTPClient.swift
//  atriusClient
//
//  Created by Manjinder Sandhu on 07/10/23.
//

import Foundation


enum NetworkError: Error {
    case badRequest
    case serverError(String)
    case decodingError
    case invalidResponse

}

extension NetworkError: LocalizedError {
    
    var errorDescription: String? {
        switch self {
            case .badRequest:
                return NSLocalizedString("Unable to perform request", comment: "badRequestError")
            case .serverError(let errorMessage):
                return NSLocalizedString(errorMessage, comment: "serverError")
            case .decodingError:
                return NSLocalizedString("Unable to decode successfully.", comment: "decodingError")
            case .invalidResponse:
                return NSLocalizedString("Invalid response", comment: "invalidResponse")
        }
    }
    
}

enum HTTPMethod {
    case get([URLQueryItem]) // useful for sorting etc
    case post(Data?)
    case put(Data?)
    case delete
    case patch(Data?)
    
    var name: String { // computed property to return the string value of HTTP methods
        switch self {
            case .get:
                return "GET"
            case .post:
                return "POST"
            case .put:
            return "PUT"
            case .delete:
                return "DELETE"
            case .patch:
            return "PATCH"
        }
    }
}

struct Resource<T: Codable> {
    let url: URL
    var method: HTTPMethod = .get([])
    var modelType: T.Type // model type you are going to fetch
}


struct HTTPClient {
    
    private var defaultHeaders: [String: String] {
            
            var headers = ["Content-Type": "application/json"]
        //TODO: BEARER
//            let model = AtriusModel()
//            let token = keychainToken
//        guard let token = model.getStoredToken() else {
//                return headers
//            }
//            
//            headers["Authorization"] = "Bearer \(token)"
            return headers
        }
    
    func load<T: Codable>(_ resource: Resource<T>) async throws -> T {
        
        var request = URLRequest(url: resource.url)
        
        switch resource.method {
            case .get(let queryItems):
                var components = URLComponents(url: resource.url, resolvingAgainstBaseURL: false)
                components?.queryItems = queryItems
                guard let url = components?.url else {
                        throw NetworkError.badRequest
                }
                
                request = URLRequest(url: url)
                
            case .post(let data):
                request.httpMethod = resource.method.name
                request.httpBody = data
            case .put(let data):
            request.httpMethod = resource.method.name
            request.httpBody = data
            case .patch(let data):
                request.httpMethod = resource.method.name
                request.httpBody = data
            
            case .delete:
                request.httpMethod = resource.method.name
        
        }
        
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = defaultHeaders
        let session = URLSession(configuration: configuration)
        
        let (data, response) = try await session.data(for: request)
        
        guard let _ = response as? HTTPURLResponse else {
                throw NetworkError.invalidResponse
        }
        
//        switch httpResponse.statusCode {
//            case 409:
//                throw NetworkError.serverError("Username is already taken.")
//            default:
//                break
//        }
        
        guard let result = try? JSONDecoder().decode(resource.modelType, from: data) else {
            throw NetworkError.decodingError
        }
        
        return result
    }
    
}
