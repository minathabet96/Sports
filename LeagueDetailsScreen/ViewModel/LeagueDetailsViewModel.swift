//
//  LeagueDetailsViewModel.swift
//  Sports
//
//  Created by Samuel Adel on 14/05/2024.
//

import Foundation
class LeagueDetailsViewModel{
    let network: Fetchable
    var leagueDetails: [LeagueDetailsModel] = []
    let leagueID: Int
   // let sport
    var leaguesViewBinder: () -> () = {}
    init(network: Fetchable, leagueID: Int) {
        self.network = network
        self.leagueID = leagueID
    }
    func fetchData() {
        network.fetchData(urlString:  "https://apiv2.allsportsapi.com/football/?met=Fixtures&leagueId=205&from=2023-01-18&to=2024-01-18&APIkey=00df14beddee4ef5d0efee2255fde53ef246055b52806f3c699c4d5af73704e6") {
            [weak self] data in
            let response: LeageDetailsApiResult  = DataDecoder.shared.decode(data: data)
            self?.leagueDetails = response.result
            self?.leaguesViewBinder()

        }
    }
    func getLeagueDetails() -> [LeagueDetailsModel] {
        return leagueDetails
    }
}
