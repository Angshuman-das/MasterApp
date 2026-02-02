//
//  Constants.swift
//  MasterApp
//
//  Created by Angshuman on 02/02/26.
//

import Foundation

enum Constants {
    enum URLConstants {
        static let stockBaseURL = URL(string: "https://api.tickertape.in/stocks")!
    }
    
    enum URLPath: String {
        case getStocks = "/quotes"
    }
    
    enum UserDefaultKeys: String {
        case wishlist = "com.wishlist.stockItem"
    }
}
