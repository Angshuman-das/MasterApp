//
//  StockListViewModel.swift
//  MasterApp
//
//  Created by Angshuman on 02/02/26.
//

import Foundation
import Combine

protocol StockListViewModelProtocol: ObservableObject {
    var stocks: [StockData] { get }
    
    func getStocks() async throws -> [StockData]
    func startPolling() async
    func stopPolling()
}

class StockListViewModel: StockListViewModelProtocol {
    @Published var stocks: [StockData] = []
    
    private var dataManager: StockDataManagerProtocol
    private var pollingTask: Task<Void, Never>?
    
    init(
        dataManager: StockDataManagerProtocol = StockDataManager()
    ) {
        self.dataManager = dataManager
    }
    
    func getStocks() async -> [StockData] {
        do {
            let stockData = try await dataManager.getStocks()
            return stockData.data
        } catch {
            print(error)
            return []
        }
    }
    
    func startPolling() async {
        pollingTask = Task {
            while !Task.isCancelled {
                do {
                    self.stocks = await getStocks()
                    try await Task.sleep(for: .seconds(5))
                } catch is CancellationError {
                    break
                } catch {
                    print(error)
                }
            }
        }
    }
    
    func stopPolling() {
        pollingTask?.cancel()
    }
    
    
}
