//
//  NetworkError.swift
//  MasterApp
//
//  Created by Angshuman on 02/02/26.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case invalidStatusCode(Int)
    case encodingError(Error)
    case decodingError(Error)
    case unknown(Error)
}


