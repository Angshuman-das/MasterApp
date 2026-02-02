//
//  RequestGenerator.swift
//  MasterApp
//
//  Created by Angshuman on 02/02/26.
//

import Foundation

protocol RequestGeneratorProtocol {
    func generate(_ target: NetworkTarget) throws -> URLRequest
}

final class RequestGenerator: RequestGeneratorProtocol {
    func generate(_ target: NetworkTarget) throws -> URLRequest {
        guard var components = URLComponents(
            url: target.baseURL.appending(path: target.path),
            resolvingAgainstBaseURL: true
        ) else {
            throw NetworkError.invalidURL
        }
        
        if let queryParams = target.queryParams {
            components.queryItems = queryParams.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
        }
        
        guard let url = components.url else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = target.method.rawValue
        request.allHTTPHeaderFields = target.headers
        
        if let bodyParams = target.bodyParams {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: bodyParams, options: [])
            } catch {
                throw NetworkError.encodingError(error)
            }
        }
        
        return request
    }
}
