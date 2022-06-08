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
        
        let weeklyPeriod = Period(name: "W", prices: response.prices.map { $0.price }.reversed()[0...6].reversed())
        
        let monthlyPeriod = Period(name: "1M", prices: response.prices.map { $0.price }.reversed()[0...29].reversed())

        let sixMonthlyPeriod = Period(name: "6M", prices: response.prices.map { $0.price }.reversed()[0...182].reversed())

        let yearPeriod = Period(name: "1Y", prices: response.prices.map { $0.price }.reversed()[0...364].reversed())

        return GraphModel(periods: [weeklyPeriod, monthlyPeriod, sixMonthlyPeriod, yearPeriod])
    }
}
