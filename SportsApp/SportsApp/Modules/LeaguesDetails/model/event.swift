//
//  event.swift
//  SportsApp
//
//  Created by Shady Adel on 19/08/2024.
//


import Foundation



struct tennis: Decodable {
    let leagueName: String?
    let leagueKey: Int?
    let time: String?
    let date: String?
    let home: String?
    let homeKey: Int?
    let away: String?
    let awayKey: Int?
    let homelogo: String?
    let awaylogo: String?
    
    enum CodingKeys: String, CodingKey {
        case leagueName = "league_name"
        case leagueKey = "league_key"
        case time = "event_time"
        case date = "event_date"
        case home = "event_first_player"
        case homeKey = "first_player_key"
        case away = "event_second_player"
        case awayKey = "second_player_key"
        case homelogo = "event_first_player_logo"
        case awaylogo = "event_second_player_logo"
    }
}

struct tennisResponse: Decodable {
    let success: Int
    let result: [tennis]
}

struct football: Decodable {
    let home: String?
    let away: String?
    let date: String?
    let time: String?
    let score: String?
    let homelogo: String?
    let awaylogo: String?
    let homeKey: Int?
    let awayKey: Int?
    
    enum CodingKeys: String, CodingKey {
        case home = "event_home_team"
        case away = "event_away_team"
        case date = "event_date"
        case time = "event_time"
        case score = "event_final_result"
        case homelogo = "home_team_logo"
        case awaylogo = "away_team_logo"
        case homeKey = "home_team_key"
        case awayKey = "away_team_key"
    }
}

struct footballResponse: Decodable {
    let result: [football]
}

struct Team {
    let name: String?
    let logo: String?
    let key: Int?
}
