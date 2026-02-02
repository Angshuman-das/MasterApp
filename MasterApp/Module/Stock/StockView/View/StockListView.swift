//
//  StockListView.swift
//  MasterApp
//
//  Created by Angshuman on 02/02/26.
//

import SwiftUI

struct StockListView<VM: StockListViewModelProtocol>: View {
    
    @StateObject var viewModel: VM
    
    init(viewModel: VM = StockListViewModel()) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack {
            List(viewModel.stocks, id: \.id) { itemData in
                StockItemView(
                    viewModel: StockItemViewModel(
                        stockItemData: itemData
                    )
                )
            }
        }
        .onAppear {
            Task {
                await viewModel.startPolling()
            }
        }
        .onDisappear {
            viewModel.stopPolling()
        }
        .navigationTitle("Stock List")
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                NavigationLink {
                    StockWishlistView()
                } label: {
                    Image(systemName: "heart")
                }
            }
        }
    }
}

#Preview {
    StockListView()
}
