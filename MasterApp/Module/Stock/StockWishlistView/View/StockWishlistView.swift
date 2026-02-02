//
//  StockWishlistView.swift
//  MasterApp
//
//  Created by Angshuman on 02/02/26.
//

import SwiftUI

struct StockWishlistView<VM: StockWishlistViewModelProtocol>: View {
    
    @StateObject var viewModel: VM
    
    init(viewModel: VM = StockWishlistViewModel()) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        Group {
            if !viewModel.wishlistItems.isEmpty {
                VStack {
                    List(viewModel.wishlistItems, id: \.self) { item in
                            Text(item)
                            .bold()
                    }
                }
            } else {
                Text("Please wishlist items to view here")
                    .font(.title2)
                    .bold()
            }
        }
        .onAppear {
            viewModel.getWishlistItems()
        }
    }
}

#Preview {
    StockWishlistView()
}
