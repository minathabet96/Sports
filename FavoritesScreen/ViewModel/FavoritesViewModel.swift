//
//  FavoritesViewModel.swift
//  Sports
//
//  Created by Mina on 14/05/2024.
//

import Foundation
class FavoritesViewModel {
    func getLeagues() -> [FavoriteLeague] {
        return CoreDataManager.shared.getFavorites()
    }
    func removeLeague(index: Int) {
        CoreDataManager.shared.removeLeague(index: index)
    }
    func addLeague(league: FavoriteLeague) {
        CoreDataManager.shared.addLeague(league: league)
    }
}
