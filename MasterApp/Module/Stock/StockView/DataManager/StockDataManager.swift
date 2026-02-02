//
//  StockDataManager.swift
//  MasterApp
//
//  Created by Angshuman on 02/02/26.
//

import Foundation

protocol StockDataManagerProtocol {
    func getStocks() async throws -> Stocks
}

final class StockDataManager: StockDataManagerProtocol {
    
    private var networkManager: NetworkManagerProtocol
    private var requestGenerator: RequestGeneratorProtocol
    private var decoder: DecoderProtocol
    
    init(
        networkManager: NetworkManagerProtocol = NetworkManager(),
        requestGenerator: RequestGeneratorProtocol = RequestGenerator(),
        decoder: DecoderProtocol = Decoder()
    ) {
        self.networkManager = networkManager
        self.requestGenerator = requestGenerator
        self.decoder = decoder
    }
    
    func getStocks() async throws -> Stocks {
        try await networkManager.request(StockRepository.getStocks, requestGenerator, decoder)
    }
}
