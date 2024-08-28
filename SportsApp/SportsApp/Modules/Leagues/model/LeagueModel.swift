//
//  leagueModel.swift
//  SportsApp
//
//  Created by Shady Adel on 18/08/2024.
//

import Foundation

struct LeagueResponse: Codable {
    let result: [League]
}

struct League: Codable {
    let leagueName: String?
    let leagueLogo: String?
    let leagueKey: Int32?

    enum CodingKeys: String, CodingKey {
        case leagueName = "league_name"
        case leagueLogo = "league_logo"
        case leagueKey = "league_key"
    }
}
