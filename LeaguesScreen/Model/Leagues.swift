//
//  Leagues.swift
//  Sports
//
//  Created by Mina on 12/05/2024.
//

import Foundation
struct Leagues: Codable {
    let success: Int
    let result: [Result]
}

struct Result: Codable {
    let leagueKey, leagueName, countryKey, countryName: String
    let leagueLogo, countryLogo: String

    enum CodingKeys: String, CodingKey {
        case leagueKey = "league_key"
        case leagueName = "league_name"
        case countryKey = "country_key"
        case countryName = "country_name"
        case leagueLogo = "league_logo"
        case countryLogo = "country_logo"
    }
}
