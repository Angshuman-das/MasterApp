//
//  StockRepository.swift
//  MasterApp
//
//  Created by Angshuman on 02/02/26.
//

import Foundation

enum StockRepository {
    case getStocks
}

extension StockRepository: NetworkTarget {
    var baseURL: URL {
        Constants.URLConstants.stockBaseURL
    }
    
    var path: String {
        switch self {
        case .getStocks:
            return Constants.URLPath.getStocks.rawValue
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getStocks:
            return .get
        }
    }
    
    var headers: StringParams? {
        nil
    }
    
    var queryParams: Params? {
        switch self {
        case .getStocks:
            return [
                "sids": ["RELI","TCS","ITC","HDBK","INFY"].joined(separator: ",")
            ]
        }
    }
    
    var bodyParams: Params? {
        nil
    }
    
    
}
