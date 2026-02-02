//
//  StockItemViewModel.swift
//  MasterApp
//
//  Created by Angshuman on 02/02/26.
//

import Combine
import Foundation

protocol StockItemViewModelProtocol: ObservableObject {
    var stockItemData: StockData { get }
    var isWishlisted: Bool { get }
    
    func wishlistTapped()
}

class StockItemViewModel: StockItemViewModelProtocol {
    @Published var isWishlisted: Bool = false
    @Published var stockItemData: StockData
    
    private var userDefaultHelper: UserDefaultHelperProtocol
    
    init(
        stockItemData: StockData,
        userDefaultHelper: UserDefaultHelperProtocol = UserDefaultHelper()
    ) {
        self.stockItemData = stockItemData
        self.userDefaultHelper = userDefaultHelper
        self.isWishlisted = checkForWishlist(stockItemData.sid)
    }
    
    func wishlistTapped() {
        toggleWishlist()
        self.isWishlisted = checkForWishlist(stockItemData.sid)
    }
}

extension StockItemViewModel {
    
    private func toggleWishlist() {
        if !isWishlisted {
            if var data: [String] = userDefaultHelper.getDataForKey(.wishlist) as? [String] {
                data.append(stockItemData.sid)
                userDefaultHelper.setDataForKey(.wishlist, val: data)
            } else {
                let data: [String] = [stockItemData.sid]
                userDefaultHelper.setDataForKey(.wishlist, val: data)
            }
        } else {
            if var data: [String] = userDefaultHelper.getDataForKey(.wishlist) as? [String] {
                data.removeAll(where: { $0 == stockItemData.sid })
                userDefaultHelper.setDataForKey(.wishlist, val: data)
            }
        }
    }
    
    private func checkForWishlist(_ id: String) -> Bool {
        guard let data = userDefaultHelper.getDataForKey(.wishlist) as? [String] else {
            return false
        }
        
        return data.contains(stockItemData.sid)
    }
}
