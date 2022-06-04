//
//  FavoritesUpdateService.swift
//  StocksApp
//
//  Created by Arthur Lee on 03.06.2022.
//

import Foundation

@objc protocol FavoritesUpdateServiceProtocol {
    func setFavoriteNotification(notification: Notification)
}

extension FavoritesUpdateServiceProtocol {
    func startObservingNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(setFavoriteNotification), name: NSNotification.Name.favoriteNotification, object: nil)
    }
    
}

extension NSNotification.Name {
    static let favoriteNotification = NSNotification.Name("set_favorite")
}

