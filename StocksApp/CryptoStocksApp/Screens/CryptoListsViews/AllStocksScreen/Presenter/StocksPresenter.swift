//
//  StocksPresenter.swift
//  StocksApp
//
//  Created by Arthur Lee on 28.05.2022.
//

import UIKit

protocol StocksViewProtocol: AnyObject {
    func updateView()
    func updateCell(for indexPath: IndexPath)
    func updateView(withLoader isLoading: Bool)
    func updateView(withError message: String)
    func showNetworkErrorAlert()
}

protocol StocksPresenterProtocol {
    var coordinator: CoordinatorProtocol? { get set }
    var view: StocksViewProtocol? { get set }
    var stocks: [StocksModelProtocol] { get }
    var itemCount: Int { get }
    func loadView()
    func moveToDetailedScreen(at index: Int)
    func model(for indexPath: Int) -> StocksModelProtocol
}


final class StocksPresenter: StocksPresenterProtocol {

    private let service: StocksServiceProtocol
    
    var coordinator: CoordinatorProtocol?
    
    var stocks: [StocksModelProtocol] = []

    var itemCount: Int {
        stocks.count
    }
    
    init(service: StocksServiceProtocol) {
        self.service = service
    }
    
    weak var view: StocksViewProtocol?

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
                self?.view?.showNetworkErrorAlert()
            }
        }
    }
    
    func model(for indexPath: Int) -> StocksModelProtocol {
        stocks[indexPath]
    }
    
    func moveToDetailedScreen(at index: Int) {
        coordinator?.moveFromAllStocks(with: model(for: index))
    }
}

extension StocksPresenter: FavoritesUpdateServiceProtocol {
    
    func setFavoriteNotification(notification: Notification) {
        guard let id = notification.stockID else { return }
        guard let index = stocks.firstIndex(where: { $0.id == id }) else { return }
        let indexPath = IndexPath(row: index, section: 0)
        view?.updateCell(for: indexPath)
    }
}
