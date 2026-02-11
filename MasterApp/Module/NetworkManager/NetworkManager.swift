//
//  NetworkManager.swift
//  MasterApp
//
//  Created by Angshuman on 02/02/26.
//

import Foundation

protocol NetworkManagerProtocol {
    func request<T: Decodable>(
        _ target: NetworkTarget,
        _ requestGenerator: RequestGeneratorProtocol,
        _ decoder: DecoderProtocol
    ) async throws -> T
}

final class NetworkManager: NetworkManagerProtocol {
    func request<T>(
        _ target: NetworkTarget,
        _ requestGenerator: RequestGeneratorProtocol,
        _ decoder: DecoderProtocol
    ) async throws -> T where T : Decodable {
        let request = try requestGenerator.generate(target)
        
        var data: Data
        var response: URLResponse
        
        do {
            (data, response) = try await URLSession.shared.data(for: request)
        } catch {
            throw NetworkError.invalidResponse
        }
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        
        guard httpResponse.statusCode == 200 else {
            throw NetworkError.invalidStatusCode(httpResponse.statusCode)
        }
        
        return try decoder.decode(data)
    }
}
