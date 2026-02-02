//
//  Untitled.swift
//  MasterApp
//
//  Created by Angshuman on 02/02/26.
//

import Foundation
import Combine

protocol StockWishlistViewModelProtocol: ObservableObject {
    var wishlistItems: [String] { get }
    
    func getWishlistItems()
}

final class StockWishlistViewModel: StockWishlistViewModelProtocol {
    @Published var wishlistItems: [String] = []
    
    private var userDefaultHelper: UserDefaultHelperProtocol
    
    init(
        userDefaultHelper: UserDefaultHelperProtocol = UserDefaultHelper()
    ) {
        self.userDefaultHelper = userDefaultHelper
    }
}

extension StockWishlistViewModel {
    func getWishlistItems() {
        guard let items: [String] = userDefaultHelper.getDataForKey(.wishlist) as? [String] else {
            return
        }
        
        wishlistItems.append(contentsOf: items)
    }
}
