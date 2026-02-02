//
//  Decoder.swift
//  MasterApp
//
//  Created by Angshuman on 02/02/26.
//

import Foundation

protocol DecoderProtocol {
    func decode<T: Decodable>(_ data: Data) throws -> T
}

final class Decoder: DecoderProtocol {
    func decode<T>(_ data: Data) throws -> T where T : Decodable {
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw NetworkError.decodingError(error)
        }
    }
}
