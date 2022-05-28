//
//  AppDelegate.swift
//  StocksApp
//
//  Created by Arthur Lee on 24.05.2022.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = ModuleBuilder.shared.tabBarController()
        window?.makeKeyAndVisible()
        return true
    }
}

/// Checking Data Loading

/*
class MockService: StocksServiceProtocol {
    func getStocks(currency: String, count: String, completion: @escaping (Result<[Stock], NetworkError>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            completion(.failure(.taskError))
        }
    }
}
*/
