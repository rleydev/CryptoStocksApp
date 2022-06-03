//
//  TabBarViewController.swift
//  StocksApp
//
//  Created by Arthur Lee on 26.05.2022.
//

import UIKit

final class TabBarViewController: UITabBarController {
    
    private let fisrtController: UINavigationController = {
        let controller = StocksViewController()
        controller.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "chart.line.uptrend.xyaxis"), tag: 1)
        let navigationController = UINavigationController(rootViewController: controller)
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.navigationBar.topItem?.title = "Crypto Stocks"
        return navigationController
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllers = [fisrtController]
        
    }
    
}
