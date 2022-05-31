//
//  StocksService.swift
//  StocksApp
//
//  Created by Arthur Lee on 26.05.2022.
//

import Foundation

protocol StocksServiceProtocol {
    func getStocks(currency: String, count: String, completion: @escaping (Result<[Stock], NetworkError>) -> Void)
    func getStocks(currency: String, completion: @escaping (Result<[Stock], NetworkError>) -> Void)
    func getStocks(completion: @escaping (Result<[Stock], NetworkError>) -> Void)
    func getStock(id: String, currency: String, daysCount: String, interval: String, completion: @escaping (Result<StockPrices, NetworkError>) -> Void)
    func getStock(id: String, completion: @escaping (Result<StockPrices, NetworkError>) -> Void)
}


final class StocksService: StocksServiceProtocol {
    
    private let client: NetworkService
    
    init(client: NetworkService) {
        self.client = client
    }
    
    func getStocks(currency: String, count: String, completion: @escaping (Result<[Stock], NetworkError>) -> Void) {
        client.execute(with: StocksRouter.stocks(currency: currency, count: count), completion: completion)
    }
    
    func getStock(id: String, currency: String, daysCount: String, interval: String, completion: @escaping (Result<StockPrices, NetworkError>) -> Void) {
        client.execute(with: StocksRouter.stock(id: id, currency: currency, daysCount: daysCount, intervalDaily: interval), completion: completion)
    }
    
}


extension StocksServiceProtocol {
    
    func getStocks(currency: String, completion: @escaping (Result<[Stock], NetworkError>) -> Void) {
        getStocks(currency: currency, count: "100", completion: completion)
    }
    
    func getStocks(completion: @escaping (Result<[Stock], NetworkError>) -> Void) {
        getStocks(currency: "usd", completion: completion)
    }
    
    func getStock(id: String, completion: @escaping (Result<StockPrices, NetworkError>) -> Void) {
        getStock(id: id, currency: "usd", daysCount: "600", interval: "daily", completion: completion)
    }
    

}
