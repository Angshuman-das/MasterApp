//
//  Untitled.swift
//  MasterApp
//
//  Created by Angshuman on 02/02/26.
//

import Foundation

extension Double {
    var formattedPrice: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 0
        formatter.minimumIntegerDigits = 2
        return formatter.string(from: NSNumber(value: self)) ?? "\(self)"
    }
}
