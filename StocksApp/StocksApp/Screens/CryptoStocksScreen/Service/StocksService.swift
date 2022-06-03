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
    
    func getCharts(id: String, currency: String, days: String, isDaily: Bool, completion: @escaping (Result<Charts, NetworkError>) -> Void)
}


final class StocksService: StocksServiceProtocol {
    
    private let client: NetworkService
    
    init(client: NetworkService) {
        self.client = client
    }
    
    func getStocks(currency: String, count: String, completion: @escaping (Result<[Stock], NetworkError>) -> Void) {
        client.execute(with: StocksRouter.stocks(currency: currency, count: count), completion: completion)
    }
    
    func getCharts(id: String, currency: String, days: String, isDaily: Bool, completion: @escaping (Result<Charts, NetworkError>) -> Void) {
        client.execute(with: StocksRouter.stock(id: id, currency: currency, daysCount: days, intervalDaily: isDaily), completion: completion)
    }
    

}

extension StocksServiceProtocol {
    func getStocks(currency: String, completion: @escaping (Result<[Stock], NetworkError>) -> Void) {
        getStocks(currency: currency, count: "100", completion: completion)
    }
    
    func getStocks(completion: @escaping (Result<[Stock], NetworkError>) -> Void) {
        getStocks(currency: "usd", completion: completion)
    }
    
}
