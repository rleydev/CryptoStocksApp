//
//  FavoritesService.swift
//  StocksApp
//
//  Created by Arthur Lee on 31.05.2022.
//

import Foundation

protocol FavoriteServiceProtocol {
    func save(id: String)
    func remove(id: String)
    func isFavourite(for id: String) -> Bool
}

final class FavoriteService: FavoriteServiceProtocol {
    
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
    
    func isFavourite(for id: String) -> Bool {
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

final class FavoritesLocalService: FavoriteServiceProtocol {
    private lazy var path: URL = {
        FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0].appendingPathComponent("Favorites")
    }()
    
    private lazy var favoriteIds: [String] = {
        do {
            let data = try Data(contentsOf: path)
            return try JSONDecoder().decode([String].self, from: data)
        } catch {
            print("FileManager ReadError -", error.localizedDescription)
        }
        
        return []
    }()
    
    func save(id: String) {
        favoriteIds.append(id)
        updateRepo()
    }
    
    func remove(id: String) {
        if let index = favoriteIds.firstIndex(where: { $0 == id }) {
            favoriteIds.remove(at: index)
        }
        updateRepo()
    }
    
    func isFavourite(for id: String) -> Bool {
        favoriteIds.contains(id)
    }
    
    private func updateRepo() {
        do {
            let data = try JSONEncoder().encode(favoriteIds)
            try data.write(to: path)
        } catch {
            print("FileManager writeError -", error.localizedDescription)
        }
    }
    
}

