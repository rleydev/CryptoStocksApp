//
//  ModuleBuilder.swift
//  StocksApp
//
//  Created by Arthur Lee on 28.05.2022.
//

import Foundation
import UIKit

final class ModuleBuilder {
    
    private init() {}
    
    private lazy var network: NetworkService = {
        Network()
    }()
    static let shared: ModuleBuilder = .init()
    
    let favouriteService: FavoriteServiceProtocol = FavoritesServiceFileManager()
    
    private func networkService() -> NetworkService {
        network
    }
    private func stockService() -> StocksServiceProtocol {
        StocksService(client: network)
    }
    
    private func stocksModule() -> UIViewController {
        let presenter = StocksPresenter(service: stockService())
        let view = StocksViewController(presenter: presenter)
        presenter.view = view
        return view
    }
    
    func secondVC() -> UIViewController {
        let presenter = FavoriteStocksPresenter(service: stockService())
        let view = FavoritesStocksView(presenter: presenter)
        presenter.view = view
        return view
        
    }
    
    func thirdVC() -> UIViewController {
        UIViewController()
    }
    
    func tabBarController() -> UIViewController {
        let tabBar = UITabBarController()
        let stocksVC = stocksModule()
        stocksVC.tabBarItem = UITabBarItem(title: "All Crypto", image: UIImage(systemName: "chart.line.uptrend.xyaxis"), tag: 0)
        
        let secondVC = secondVC()
        secondVC.tabBarItem = UITabBarItem(title: "Favorite", image: UIImage(systemName: "star"), tag: 1)
        
        let thirdVC = thirdVC()
        thirdVC.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 2)
        
        tabBar.viewControllers = [stocksVC, secondVC, thirdVC].map { UINavigationController (rootViewController: $0)}
        return tabBar 
    }
    
    
   
}
