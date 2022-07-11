//
//  GraphModel.swift
//  StocksApp
//
//  Created by Arthur Lee on 05.06.2022.
//

import Foundation

struct GraphModel {
    
    var periods: [Period]

    struct Period {
        let name: String
        let prices: [Double]
    }
    
    func build(from response: Graph) -> GraphModel {
        
        let weeklyPeriod = Period(name: "W", prices: response.prices.map { $0.price }.suffix(7))
        
        let monthlyPeriod = Period(name: "1M", prices: response.prices.map { $0.price }.suffix(30))

        let sixMonthlyPeriod = Period(name: "6M", prices: response.prices.map { $0.price }.suffix(182))

        let yearPeriod = Period(name: "1Y", prices: response.prices.map { $0.price }.suffix(365))

        return GraphModel(periods: [weeklyPeriod, monthlyPeriod, sixMonthlyPeriod, yearPeriod])
    }
}
