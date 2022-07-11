//
//  Coordinator.swift
//  CryptoStocksApp
//
//  Created by Arthur Lee on 11.07.2022.
//

import UIKit

protocol CoordinatorProtocol {
    var allStocksView: StocksViewProtocol? { get set }
    var favoriteView: FavoriteStocksViewProtocol? { get set }
    var searchView: SearchStocksViewProtocol? { get set }
    func moveFromAllStocks(with model: StocksModelProtocol)
    func moveFromFavoriteStocks(with model: StocksModelProtocol)
    func moveFromSearchStocks(with model: StocksModelProtocol)
}

final class Coordinator: CoordinatorProtocol {
    weak var allStocksView: StocksViewProtocol?
    weak var favoriteView: FavoriteStocksViewProtocol?
    weak var searchView: SearchStocksViewProtocol?
    
    func moveFromAllStocks(with model: StocksModelProtocol) {
        let detailedVC = Assembly.shared.detailedVC(for: model)
        (allStocksView as? StocksViewController)?.navigationController?.pushViewController(detailedVC, animated: true)
    }
    
    func moveFromFavoriteStocks(with model: StocksModelProtocol) {
        let detailedVC = Assembly.shared.detailedVC(for: model)
        (favoriteView as? FavoritesStocksViewController)?.navigationController?.pushViewController(detailedVC, animated: true)
    }
    
    func moveFromSearchStocks(with model: StocksModelProtocol) {
        let detailedVC = Assembly.shared.detailedVC(for: model)
        (searchView as? SearchStocksViewController)?.navigationController?.pushViewController(detailedVC, animated: true)
    }
}
