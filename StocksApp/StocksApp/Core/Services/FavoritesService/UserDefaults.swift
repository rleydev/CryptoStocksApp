//
//  FavoritesService.swift
//  StocksApp
//
//  Created by Arthur Lee on 31.05.2022.
//


import UIKit

final class FavoriteServiceUserDefaults: FavoriteServiceProtocol {

    private let key = "favourite_key"
    private lazy var favoriteIds: [String] = {
        guard let data = UserDefaults.standard.object(forKey: key) as? Data, let ids = try? JSONDecoder().decode([String].self, from: data)
        else {
            return []
        }
        return ids
    }()


    func save(id: String) {
        favoriteIds.append(id)
        updateRepo()
    }

    func remove(id: String) {
        if let index = favoriteIds.firstIndex(where: { $0 == id }) {
            favoriteIds.remove(at: index)
            updateRepo()
        }

    }

    func isFavorite(for id: String) -> Bool {
        favoriteIds.contains(id)
    }

    private func updateRepo() {
        guard let data = try? JSONEncoder().encode(favoriteIds) else {
            return
        }
        UserDefaults.standard.set(data, forKey: key)
        print("USerdef updated")
    }

}




