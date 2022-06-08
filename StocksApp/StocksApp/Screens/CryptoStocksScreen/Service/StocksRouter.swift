//
//  StocksRouter.swift
//  StocksApp
//
//  Created by Arthur Lee on 28.05.2022.
//

import Foundation

enum StocksRouter: Router {
    
    case stocks(currency: String, count: String)
    case stock(id: String, currency: String, daysCount: String, intervalDaily: Bool)
    
    var baseUrl: String {
        "https://api.coingecko.com"
    }
    
    var path: String {
        switch self {
        case .stocks:
            return "/api/v3/coins/markets"
        case .stock(let id, _, _, _):
            return "/api/v3/coins/\(id)/market_chart"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .stocks, .stock:
            return .get
        }
        
    }
    
    var parameters: Parameters {
        switch self {
        case .stocks(let currency, let count):
            return ["vs_currency": currency, "per_page": count]
        case .stock(_, let currency, let daysCount, let intervalDaily):
            return ["vs_currency": currency, "days": daysCount, "interval": intervalDaily ? "daily": ""]
        }
    }
    
}
