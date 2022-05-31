//
//  StockModel.swift
//  StocksApp
//
//  Created by Arthur Lee on 26.05.2022.
//

import UIKit

protocol StocksModelProtocol {
    var id: String { get }
    var name: String { get }
    var iconURL: String { get }
    var symbol: String { get }
    var price: String { get }
    var priceChanged: String { get }
    var changeColor: UIColor { get }
    
    var isFavorite: Bool { get set }
    
    func setFavourite()
}

final class StockModel: StocksModelProtocol {
    
    private let stock: Stock
    private let favoriteService: FavoriteServiceProtocol
    
    init(stock: Stock) {
        self.stock = stock
        favoriteService = ModuleBuilder.shared.favouriteService
        isFavorite = favoriteService.isFavourite(for: id)
    }

    
    var id: String {
        stock.id
        
    }
    
    var name: String {
        stock.name
    }
    
    var iconURL: String {
        stock.image
    }
    
    var symbol: String {
        stock.symbol
    }
    
    var price: String {
        "$\(String(format: "%.2f", stock.price))"
    }
    
    var priceChanged: String {
        "$\(String(format: "%.2f", stock.change)) (\(String(format: "%2.f", stock.changePercentage))%)"
    }
    
    var changeColor: UIColor {
        stock.change >= 0 ? UIColor(r: 36, g: 178, b: 93) : .red
    }

    
    var isFavorite: Bool = false
    
    func setFavourite() {
        isFavorite.toggle()
        
        if isFavorite {
            favoriteService.save(id: id)
        }
    }
    
}



