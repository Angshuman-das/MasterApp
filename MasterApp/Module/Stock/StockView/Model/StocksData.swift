//
//  StocksData.swift
//  MasterApp
//
//  Created by Angshuman on 02/02/26.
//

import Foundation
import SwiftUI

struct Stocks: Decodable {
    let success: Bool
    let data: [StockData]
}

struct StockData: Identifiable, Decodable {
    var id: UUID = UUID()
    var sid: String
    var price: Double
    var close: Double
    var change: Double
    
    enum CodingKeys: String, CodingKey {
        case sid, price, close, change
    }
}

extension StockData {
    var backgroundColor: Color {
        if change > 0 {
            return Color.green
        } else if change < 0 {
            return Color.red
        } else {
            return Color.white
        }
    }
    
    var isProfit: Bool {
        change >= 0
    }
}
