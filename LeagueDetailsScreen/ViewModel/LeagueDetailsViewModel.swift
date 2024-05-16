//
//  LeagueDetailsViewModel.swift
//  Sports
//
//  Created by Samuel Adel on 14/05/2024.
//

import Foundation
class LeagueDetailsViewModel{
   private let network: Fetchable
    private var leagueUpComingEvents: [LeagueDetailsModel] = []
    private  var leagueLatestResults: [LeagueDetailsModel] = []
    private  var leagueTeams: [LeagueDetailsModel] = []
    private  let league: Result
    private  let sportType: String
    private  var selectedTeamId:Int?
    var upcomingEventsViewBinder: () -> () = {}
    var latestResultsViewBinder: () -> () = {}
    var leagueImageLoaded: () -> () = {}
    var leageFavModel:FavoriteLeague?
    init(network: Fetchable, league: Result, sportType: String) {
           self.network = network
           self.league = league
           self.sportType = sportType
        self.setupFavLeagueModel()
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
        let urlString = "\(APIHelper.baseUrl)\(sportType)/?met=Fixtures&leagueId=\(league.leagueID)&from=\(fromDate)&to=\(toDate)&APIkey=\(APIHelper.apiKey)"
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
        
        let urlString = "https://apiv2.allsportsapi.com/\(sportType)/?met=Fixtures&leagueId=\(league.leagueID)&from=\(fromDate)&to=\(toDate)&APIkey=00df14beddee4ef5d0efee2255fde53ef246055b52806f3c699c4d5af73704e6"
        
        return urlString
    }


    func fetchData() {
        
        print("leagueID")
        print(league.leagueID)
        print(upcomingEvnetsURl())
        print(latestResultsURL())
        network.fetchData(urlString:  upcomingEvnetsURl()) {
            [weak self] data in
            let response: LeageDetailsApiResult  = DataDecoder.shared.decode(data: data)
            if(response.result != nil){
                self?.leagueUpComingEvents = response.result!
                self?.leagueTeams.append(contentsOf: response.result!)
                self?.upcomingEventsViewBinder()
            }else{
                self?.upcomingEventsViewBinder()
            }
            
        }
        network.fetchData(urlString:  latestResultsURL()) {
            [weak self] data in
            let response: LeageDetailsApiResult  = DataDecoder.shared.decode(data: data)
            if response.result != nil {
                self?.leagueLatestResults = response.result!
                self?.leagueTeams.append(contentsOf: response.result!)
                self?.upcomingEventsViewBinder()
            }else{
                self?.upcomingEventsViewBinder()
            }
        
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
    func setSelectedTeamId(teamId:Int){
        selectedTeamId=teamId
    }
    func getSelectedTeamId()->Int?{
        return selectedTeamId
    }
    func getSportType()->String{
        return sportType
    }
    func getCurrentLeagueData()->Result{
        return league
    }
    func setupFavLeagueModel(){
        network.fetchData(urlString:league.leagueLogo ?? getDefaultUrl()){[weak self] img in
            DispatchQueue.main.async {
                self?.leageFavModel=FavoriteLeague(id:self?.league.leagueID ?? 0, title:self?.league.leagueName ?? "unkown",type: self?.sportType ?? "football", img: img)
            }
        }
    }
    func getLeagueFavModel()->FavoriteLeague{
        return leageFavModel!
    }
    
    func getDefaultUrl()->String{
        var url: String
        switch sportType {
            case "tennis":
                url = "https://static.vecteezy.com/system/resources/previews/000/488/409/original/tennis-cup-winner-gold-stock-vector-illustration.jpg"
            case "basketball":
                url = "https://www.fiba.basketball/api/img/graphic/5f1a2c53-ff81-4b23-9c4f-bd85d75c6d98/1000/1000?mt=.jpg"
            case "cricket":
                url = "https://5.imimg.com/data5/SELLER/Default/2021/7/BM/TC/ED/5388092/4-500x500.JPG"
            default:
                url = "https://cloudfront-us-east-2.images.arcpublishing.com/reuters/5ZD3FGEX2JJU7FZSN2FDIIXFQ4.jpg"
        }
        return url
    }
}
