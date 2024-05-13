//
//  Leagues.swift
//  Sports
//
//  Created by Mina on 12/05/2024.
//

import Foundation
struct Leagues: Codable {
    var success: Int
    var result: [Result]
}

struct Result: Codable {
    let leagueName, countryName: String?
    let leagueLogo: String?

    enum CodingKeys: String, CodingKey {
        //case leagueKey = "league_key"
        case leagueName = "league_name"
        //case countryKey = "country_key"
        case countryName = "country_name"
        case leagueLogo = "league_logo"
        //case countryLogo = "country_logo"
    }
}
