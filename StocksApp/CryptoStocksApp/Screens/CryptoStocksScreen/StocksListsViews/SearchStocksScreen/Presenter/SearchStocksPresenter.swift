//
//  SearchStocksPresenter.swift
//  StocksApp
//
//  Created by Arthur Lee on 07.06.2022.
//

import Foundation

protocol SearchStocksViewProtocol: AnyObject {
    func updateView()
    func updateCell(for indexPath: IndexPath)
    func updateView(withLoader isLoading: Bool)
    func updateView(withError message: String)

}

protocol SearchStocksPresenterProtocol {
    var view: SearchStocksViewProtocol? { get set }
    var stocks: [StocksModelProtocol] { get }
    var itemCount: Int { get }
    func loadView()
    func model(for indexPath: IndexPath) -> StocksModelProtocol
    func searchStock(searching text: String)
}


final class SearchStocksPresenter: SearchStocksPresenterProtocol {
    
    private let service: StocksServiceProtocol
    
    var stocks: [StocksModelProtocol] = []

    var itemCount: Int {
        stocks.count
    }
    
    init(service: StocksServiceProtocol) {
        self.service = service
    }
    
    weak var view: SearchStocksViewProtocol?

    func loadView() {
        startObservingNotifications()
        
        view?.updateView(withLoader: true)

// Getting back with data and delete loader
        service.getStocks { [weak self] result in
            self?.view?.updateView(withLoader: false)
            
            switch result {
            case .success(let stocks):
                self?.stocks = stocks
                self?.view?.updateView()
            case .failure(let error):
                self?.view?.updateView(withError: error.localizedDescription)
            }
        }
    }
    
    func model(for indexPath: IndexPath) -> StocksModelProtocol {
        stocks[indexPath.row]
    }
    
    func searchStock(searching text: String) {
        startObservingNotifications()

        service.getStocks { [weak self] result in
            self?.view?.updateView(withLoader: false)
            
            switch result {
            case .success(let stocks):
                self?.stocks = stocks.filter({ $0.id.contains(text) || $0.name.contains(text) || $0.symbol.contains(text)})
                self?.view?.updateView()
            case .failure(let error):
                self?.view?.updateView(withError: error.localizedDescription)
            }
        }
    }
 
}

extension SearchStocksPresenter: FavoritesUpdateServiceProtocol {
    
    func setFavoriteNotification(notification: Notification) {
        guard let id = notification.stockID, let index = stocks.firstIndex(where: { $0.id == id }) else { return }
        let indexPath = IndexPath(row: index, section: 0)

        view?.updateCell(for: indexPath)
    }

}
