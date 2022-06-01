//
//  FavotirtesServiceProtocol.swift
//  StocksApp
//
//  Created by Arthur Lee on 31.05.2022.
//

import UIKit

protocol FavoriteServiceProtocol {
    func save(id: String)
    func remove(id: String)
    func isFavorite(for id: String) -> Bool
}
