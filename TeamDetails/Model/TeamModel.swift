//
//  TeamModel.swift
//  Sports
//
//  Created by Samuel Adel on 15/05/2024.
//

import Foundation
struct Team:Codable{
    let teamKey:Int?
    let teamName:String?
    let teamLogo:String?
    let teamPlayers:[Player]?
    let teamCoach:[Coach]?
    enum CodingKeys: String, CodingKey {
        case teamKey = "team_key"
        case teamName = "team_name"
        case teamLogo = "team_logo"
        case teamPlayers = "players"
        case teamCoach = "coaches"
    }
    static let empty = Team(teamKey: 0, teamName: nil, teamLogo:nil, teamPlayers: [],teamCoach: [])

}
struct Player:Codable{
    let playerKey: Int?
    let playerImage: String?
    let playerName: String?
    let position:String?
    
    enum CodingKeys: String,CodingKey {
        case playerKey = "player_key"
        case playerImage = "player_image"
        case playerName = "player_name"
        case position = "player_type"
    }
    
}
struct Coach:Codable{
    let coachName:String?
    
    enum CodingKeys: String,CodingKey {
        case coachName = "coach_name"
    }
}

struct TeamDetailsApiResult:Codable{
    let result:[Team]?
}
