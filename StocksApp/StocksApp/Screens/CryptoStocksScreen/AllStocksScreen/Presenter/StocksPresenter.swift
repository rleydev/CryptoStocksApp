//
//  StocksPresenter.swift
//  StocksApp
//
//  Created by Arthur Lee on 28.05.2022.
//

import Foundation
import UIKit

protocol StocksViewProtocol: AnyObject {
    func updateView()
    func updateView(withLoader isLoading: Bool)
    func updateView(withError message: String)
}



protocol StocksPresenterProtocol {
    var view: StocksViewProtocol? { get set }
    var stocks: [StocksModelProtocol] { get }
    var itemCount: Int { get }
    func loadView()
    func model(for indexPath: IndexPath) -> StocksModelProtocol
    
    
}


final class StocksPresenter: StocksPresenterProtocol {
    

    private let service: StocksServiceProtocol
    
    var stocks: [StocksModelProtocol] = []
    
    var itemCount: Int {
        stocks.count
    }
    
    init(service: StocksServiceProtocol) {
        self.service = service
    }
    
    weak var view: StocksViewProtocol?
    
    func loadView() {
        view?.updateView(withLoader: true)

// Getting back with data and delete loader
        service.getStocks { [weak self] result in
            self?.view?.updateView(withLoader: false)
            
            switch result {
            case .success(let stocks):
                self?.stocks = stocks.map { StockModel(stock: $0) }
                self?.view?.updateView()
            case .failure(let error):
                self?.view?.updateView(withError: error.localizedDescription)
            }
        }
    }
        
    
    func model(for indexPath: IndexPath) -> StocksModelProtocol {
        stocks[indexPath.row]
    }
    
}

