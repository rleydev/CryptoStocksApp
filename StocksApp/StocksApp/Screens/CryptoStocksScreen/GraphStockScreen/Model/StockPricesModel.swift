//
//  StockPricesModel.swift
//  StocksApp
//
//  Created by Arthur Lee on 29.05.2022.
//

import Foundation

protocol StockPricesModelProtocol {
    var prices: [[Double]] { get }
}

final class StockPricesModel: StockPricesModelProtocol {
    
    private let stockPrices: StockPrices
    
    init(stockPrices: StockPrices) {
        self.stockPrices = stockPrices
    }
    
    var prices: [[Double]] {
        stockPrices.prices
    }
    
    
}
