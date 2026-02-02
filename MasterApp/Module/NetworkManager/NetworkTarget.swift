//
//  NetworkTarget.swift
//  MasterApp
//
//  Created by Angshuman on 02/02/26.
//

import Foundation


enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

protocol NetworkTarget {
    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: StringParams? { get }
    var queryParams: Params? { get }
    var bodyParams: Params? { get }
}
