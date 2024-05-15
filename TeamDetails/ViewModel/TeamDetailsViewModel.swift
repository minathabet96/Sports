//
//  TeamDetailsViewModel.swift
//  Sports
//
//  Created by Samuel Adel on 15/05/2024.
//

import Foundation
class TeamDetailsViewModel{
    private let network: Fetchable
    private var teamDetails:Team = Team.empty
     private   let sportType: String
    private let teamId: Int
    var teamDetailsViewBinder: () -> () = {}
    init(network: Fetchable, teamId: Int, sportType:String) {
           self.network = network
           self.teamId = teamId
            self.sportType=sportType
       }
  
     func fetchData() {
         print(teamId)
         print(sportType)
         let urlString = "\(APIHelper.baseUrl)/\(sportType)/?&met=Teams&teamId=\(teamId)&APIkey=\(APIHelper.apiKey)"
         print(urlString)
         network.fetchData(urlString: urlString) {
             [weak self] data in
             let response: TeamDetailsApiResult  = DataDecoder.shared.decode(data: data)
             if(response.result != nil){
                 self?.teamDetails=response.result![0]
                 print(self?.teamDetails.teamPlayers?.first?.playerName)
                 self?.teamDetailsViewBinder()
             }else{
                 self?.teamDetailsViewBinder()
             }
             
         }
     }
    func getTeamDetails()->Team{
        return teamDetails
    }
}
