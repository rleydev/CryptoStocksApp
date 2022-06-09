//
//  StocksService.swift
//  StocksApp
//
//  Created by Arthur Lee on 26.05.2022.
//

import Foundation

protocol StocksServiceProtocol {
    func getStocks(currency: String, count: String, completion: @escaping (Result<[StocksModelProtocol], NetworkError>) -> Void)
    func getStocks(currency: String, completion: @escaping (Result<[StocksModelProtocol], NetworkError>) -> Void)
    func getStocks(completion: @escaping (Result<[StocksModelProtocol], NetworkError>) -> Void)
    
    func getCharts(id: String, currency: String, days: String, isDaily: Bool, completion: @escaping (Result<Graph, NetworkError>) -> Void)
}


final class StocksService: StocksServiceProtocol {
    
    private let client: NetworkService
    
    private var stocks: [StocksModelProtocol] = []
    
    init(client: NetworkService) {
        self.client = client
    }
    
    func getStocks(currency: String, count: String, completion: @escaping (Result<[StocksModelProtocol], NetworkError>) -> Void) {
        if stocks.isEmpty {
            fetch(currency: currency, count: count, completion: completion)
            return
        }
        completion(.success(stocks))
    }
    
    func getCharts(id: String, currency: String, days: String, isDaily: Bool, completion: @escaping (Result<Graph, NetworkError>) -> Void) {
        client.execute(with: StocksRouter.stock(id: id, currency: currency, daysCount: days, intervalDaily: isDaily), completion: completion)
    }
    
    private func fetch(currency: String, count: String, completion: @escaping (Result<[StocksModelProtocol], NetworkError>) -> Void) {
        client.execute(with: StocksRouter.stocks(currency: currency, count: count)) { [weak self] (result: Result<[Stock], NetworkError>) in
            guard let self = self else { return }
            switch result {
            case .success(let stocks):
                completion(.success(self.stockModels(for: stocks)))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func stockModels(for stocks: [Stock]) -> [StocksModelProtocol] {
        stocks.map { StockModel(stock: $0)}
    }
}

extension StocksServiceProtocol {
    func getStocks(currency: String, completion: @escaping (Result<[StocksModelProtocol], NetworkError>) -> Void) {
        getStocks(currency: currency, count: "100", completion: completion)
    }
    
    func getStocks(completion: @escaping (Result<[StocksModelProtocol], NetworkError>) -> Void) {
        getStocks(currency: "usd", completion: completion)
    }
}
