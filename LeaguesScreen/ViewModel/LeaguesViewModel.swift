//
//  LeaguesViewModel.swift
//  Sports
//
//  Created by Mina on 12/05/2024.
//

import Foundation
class LeaguesViewModel {
    let network: Fetchable
    var leagues: [Result] = []
    let sportParam: String
    var leagueId:Int?
    var leaguesViewBinder: () -> () = {}
    init(network: Fetchable, sportParam: String) {
        self.network = network
        self.sportParam = sportParam
    }
    func setLeagueId(id:Int){
        leagueId=id
    }
    func getLeagueId()->Int{
        return leagueId ?? 0
    }
    func fetchData() {
        network.fetchData(urlString:  "https://apiv2.allsportsapi.com/\(sportParam)/?met=Leagues&APIkey=00df14beddee4ef5d0efee2255fde53ef246055b52806f3c699c4d5af73704e6") { 
            [weak self] data in
            var response: Leagues  = DataDecoder.shared.decode(data: data)
            response.result.remove(at: 0)
            response.result.remove(at: 0)
            response.result.remove(at: 0)
            self?.leagues = response.result
            self?.leaguesViewBinder()

        }
    }
    func getLeagues() -> [Result] {
        return leagues
    }

}
