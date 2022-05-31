//
//  StockPresenter.swift
//  StocksApp
//
//  Created by Arthur on 28.05.2022.
//

import Foundation

protocol StockPresentProtocol {
//    var view: StockViewProtocol? { get set }
    var id: String { get set }
    var view: StocksViewProtocol? { get set }
    func loadGraphData(with idOfStock: String)
//    func model(for indexPath: IndexPath) -> StockPricesModelProtocol
    init(with id: String, withService service: StocksServiceProtocol)
}

class StockPresenter: StockPresentProtocol {
    
    weak var view: StocksViewProtocol?
    
    var service: StocksServiceProtocol

    var stockPrices: StockPricesModelProtocol?

    var id: String

    required init(with id: String, withService service: StocksServiceProtocol) {
        self.id = id
        self.service = service
    }


    func loadGraphData(with idOfStock: String) {
        id = idOfStock
        service.getStock(id: id) { [weak self] result in
            switch result {
            case .success(let pricesOfStock):
                self?.stockPrices = pricesOfStock as? StockPricesModelProtocol

            case .failure(let error):
                self?.view?.updateView(withError: error.localizedDescription)
            }
        }

   }
 
    
}
