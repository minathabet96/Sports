//
//  FavoritesViewModel.swift
//  Sports
//
//  Created by Mina on 14/05/2024.
//

import Foundation
class FavoritesViewModel {
   private var selectedLeague:FavoriteLeague?
    
    func setSelectedLeague(league:FavoriteLeague){
        selectedLeague=league
    }
    
    func getSelectedLeague()->FavoriteLeague?{
       return selectedLeague
    }
    func getLeagues() -> [FavoriteLeague] {
        return CoreDataManager.shared.getFavorites()
    }
    func removeLeague(index: Int) {
        CoreDataManager.shared.removeLeague(leagueId: index)
    }
    func addLeague(league: FavoriteLeague) {
        CoreDataManager.shared.addLeague(league: league)
    }
}
