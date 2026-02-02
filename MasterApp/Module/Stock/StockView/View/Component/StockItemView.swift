//
//  StockItemView.swift
//  MasterApp
//
//  Created by Angshuman on 02/02/26.
//

import SwiftUI

struct StockItemView<VM: StockItemViewModelProtocol>: View {
    
    @StateObject var viewModel: VM
    
    init(viewModel: VM) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack {
            HStack {
                Text(viewModel.stockItemData.sid)
                    .bold()
                Spacer()
                VStack {
                    Text(viewModel.stockItemData.close.formattedPrice)
                    Text(viewModel.stockItemData.price.formattedPrice)
                }
                .font(.system(size: 16))
                Spacer()
                
                HStack(spacing: 16) {
                    HStack {
                        Image(
                            systemName: viewModel.stockItemData.isProfit ? "chart.line.uptrend.xyaxis" : "chart.line.downtrend.xyaxis"
                        )
                        Text(viewModel.stockItemData.change.formattedPrice)
                            .font(.system(size: 16, weight: .semibold))
                    }
                    
                    Image(systemName: viewModel.isWishlisted ? "heart.fill" : "heart")
                        .onTapGesture {
                            viewModel.wishlistTapped()
                        }
                }
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .foregroundStyle(
                    viewModel.stockItemData.backgroundColor
                )
        )
    }
}

#Preview {
    StockItemView(viewModel: StockItemViewModel(stockItemData: StockData(sid: "HDFC", price: 1980.3, close: 2000.1, change: 100.2)))
    
    StockItemView(viewModel: StockItemViewModel(stockItemData: StockData(sid: "HDFC", price: 1980.3, close: 2000.1, change: -90.2)))
}
