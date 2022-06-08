//
//  FileManager.swift
//  StocksApp
//
//  Created by Arthur Lee on 31.05.2022.
//

import UIKit

final class FavoritesServiceFileManager: FavoriteServiceProtocol {

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
        updateRepo(with: id)
    }
    
    func remove(id: String) {
        if let index = favoriteIds.firstIndex(where: { $0 == id }) {
            favoriteIds.remove(at: index)
        }
        updateRepo(with: id)
    }
    
    func isFavorite(for id: String) -> Bool {
        favoriteIds.contains(id)
    }
    
    
    private func updateRepo(with id: String) {
        do {
            let data = try JSONEncoder().encode(favoriteIds)
            try data.write(to: path)
            NotificationCenter.default.post(name: NSNotification.Name.favoriteNotification, object: nil, userInfo: ["id": id])
            
        } catch {
            print("FileManager writeError -", error.localizedDescription)
        }
    }
}
