//
//  LeagueDetailsViewModel.swift
//  Sports
//
//  Created by Samuel Adel on 14/05/2024.
//

import Foundation
class LeagueDetailsViewModel{
    let network: Fetchable
    var leagueUpComingEvents: [LeagueDetailsModel] = []
    var leagueLatestResults: [LeagueDetailsModel] = []
    var leagueTeams: [LeagueDetailsModel] = []
    let leagueID: Int
    let sportType: String
    var leaguesViewBinder: () -> () = {}
    init(network: Fetchable, leagueID: Int, sportType: String) {
           self.network = network
           self.leagueID = leagueID
           self.sportType = sportType
       }
    private func upcomingEvnetsURl()->String{
        let currentDate = Date()
        var oneYearComponent = DateComponents()
        oneYearComponent.year = 1
        let nextYearDate = Calendar.current.date(byAdding: oneYearComponent, to: currentDate)!
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let fromDate = dateFormatter.string(from: currentDate)
        let toDate = dateFormatter.string(from: nextYearDate)
        print(fromDate)
        print(toDate)
        let urlString = "https://apiv2.allsportsapi.com/\(sportType)/?met=Fixtures&leagueId=\(leagueID)&from=\(fromDate)&to=\(toDate)&APIkey=00df14beddee4ef5d0efee2255fde53ef246055b52806f3c699c4d5af73704e6"
           return urlString
    }
    
    private func latestResultsURL() -> String {
        let currentDate = Date()
        var oneYearAgoComponent = DateComponents()
        oneYearAgoComponent.year = -1
        let oneYearAgoDate = Calendar.current.date(byAdding: oneYearAgoComponent, to: currentDate)!
        var oneDayAgoComponent = DateComponents()
        oneDayAgoComponent.day = -1
        let oneDayAgoDate = Calendar.current.date(byAdding: oneDayAgoComponent, to: currentDate)!
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let fromDate = dateFormatter.string(from: oneYearAgoDate)
        let toDate = dateFormatter.string(from: oneDayAgoDate)
        
        print(fromDate)
        print(toDate)
        
        let urlString = "https://apiv2.allsportsapi.com/\(sportType)/?met=Fixtures&leagueId=\(leagueID)&from=\(fromDate)&to=\(toDate)&APIkey=00df14beddee4ef5d0efee2255fde53ef246055b52806f3c699c4d5af73704e6"
        
        return urlString
    }


    func fetchData() {
        network.fetchData(urlString:  upcomingEvnetsURl()) {
            [weak self] data in
            let response: LeageDetailsApiResult  = DataDecoder.shared.decode(data: data)
            self?.leagueUpComingEvents = response.result
            self?.leagueTeams.append(contentsOf: response.result)
            self?.leaguesViewBinder()
        }
        network.fetchData(urlString:  latestResultsURL()) {
            [weak self] data in
            let response: LeageDetailsApiResult  = DataDecoder.shared.decode(data: data)
            self?.leagueLatestResults = response.result
            self?.leagueTeams.append(contentsOf: response.result)
            self?.leaguesViewBinder()

        }
    }
    func getLeagueUpcomingEvents() -> [LeagueDetailsModel] {
        return leagueUpComingEvents
    }
    func getLeagueLatestResults() -> [LeagueDetailsModel] {
        return Array(leagueLatestResults.prefix(5))
    }
    func getLeagueTeams() -> [LeagueDetailsModel] {
        return leagueTeams
    }
}