//
//  LeagueDetailsModel.swift
//  Sports
//
//  Created by Samuel Adel on 14/05/2024.
//

import Foundation
class LeagueDetailsModel{
    let eventDate:String
    let evnetTime:String
    let homeTeamName:String
    let homeTeamKey:Int
    let homeTeamLogo:String
    let awayTeamName:String
    let awayTeamKey:Int
    let awayTeamLogo:String
    let leagueName:String
    init(eventDate: String, evnetTime: String, homeTeamName: String, homeTeamKey: Int, homeTeamLogo: String, awayTeamName: String, awayTeamKey: Int, awayTeamLogo: String, leagueName: String) {
        self.eventDate = eventDate
        self.evnetTime = evnetTime
        self.homeTeamName = homeTeamName
        self.homeTeamKey = homeTeamKey
        self.homeTeamLogo = homeTeamLogo
        self.awayTeamName = awayTeamName
        self.awayTeamKey = awayTeamKey
        self.awayTeamLogo = awayTeamLogo
        self.leagueName = leagueName
    }
}
