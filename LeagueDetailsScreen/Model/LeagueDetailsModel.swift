//
//  LeagueDetailsModel.swift
//  Sports
//
//  Created by Samuel Adel on 14/05/2024.
//

import Foundation

struct LeagueDetailsModel : Codable{
    var eventDate:String
    var evnetTime:String
    var homeTeamName:String
    var homeTeamKey:Int
    var homeTeamLogo:String
    var awayTeamName:String
    var awayTeamKey:Int
    var awayTeamLogo:String
    var leagueName:String
    
    enum CodingKeys: String,CodingKey {
        case eventDate = "event_date"
        case evnetTime = "event_time"
        case homeTeamName = "event_home_team"
        case homeTeamKey = "home_team_key"
        case homeTeamLogo = "home_team_logo"
        case awayTeamName = "event_away_team"
        case awayTeamKey = "away_team_key"
        case awayTeamLogo = "away_team_logo"
        case leagueName = "league_name"
    }
    
}
struct LeageDetailsApiResult:Codable{
    var result:[LeagueDetailsModel]
}
