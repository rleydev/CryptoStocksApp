//
//  StockPresenter.swift
//  StocksApp
//
//  Created by Arthur on 28.05.2022.
//

import UIKit

protocol StockViewProtocol: AnyObject {
    func updateView()
    func updateView(withLoader isLoading: Bool)
    func updateView(withError message: String)
}


protocol StockPresentProtocol {

    var favoriteButtonIsSelected: Bool { get }
    var title: String? { get }
    var symbol: String? { get }
    var currentPrice: String? { get }
    var priceChange: String? { get }
    var changeColor: UIColor? { get }
    func favoriteButtonTapped()
    func loadView()
//    func model(for indexPath: IndexPath) -> StockPricesModelProtocol

}

final class StockPresenter: StockPresentProtocol {
    
    weak var view: StockViewProtocol?
    
    private let model: StocksModelProtocol
    
    private let service: StocksServiceProtocol
    
    var title: String? {
        model.name
    }
    
    var symbol: String? {
        model.symbol
    }
    
    var currentPrice: String? {
        model.price
    }

    var priceChange: String? {
        model.priceChanged
    }
    
    var changeColor: UIColor? {
        model.changeColor
    }
    
    var favoriteButtonIsSelected: Bool {
        model.isFavorite
    }
    

    init(model: StocksModelProtocol, service: StocksServiceProtocol) {
        self.model = model
        self.service = service
    }

    func loadView() {
        
        view?.updateView(withLoader: true)
        
        service.getCharts(id: model.id, currency: "usd", days: "100", isDaily: true) { [weak self] result in
            
            self?.view?.updateView(withLoader: false)
            
            switch result {
            case .success(let charts):
                self?.view?.updateView()
                print("Graphs count -", charts.prices.map { $0.date })
            case.failure(let error):
                self?.view?.updateView(withError: error.localizedDescription)
            }
        }
    }
    
    func favoriteButtonTapped() {
        model.setFavourite()
    }
 
    
}
