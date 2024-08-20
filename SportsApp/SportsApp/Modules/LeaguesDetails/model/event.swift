//
//  event.swift
//  SportsApp
//
//  Created by Shady Adel on 19/08/2024.
//


import Foundation


struct Event: Decodable {
    let home: String
    let away: String
    let date: String
    let time: String
    let score: String
    let homelogo: String?
    let awaylogo: String?
    let homeKey: Int
    let awayKey: Int
    
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

struct EventsResponse: Decodable {
    let result: [Event]
}


struct Result: Decodable {
    
    let homeTeam: String
    let awayTeam: String
    let score: String
    let date: String
    let time: String
    
    enum CodingKeys: String, CodingKey {
        case homeTeam = "event_home_team"
        case awayTeam = "event_away_team"
        case score = "event_final_result"
        case date = "event_date"
        case time = "event_time"
        
        
    }
}

struct ResultsResponse: Decodable {
    let result: [Result]
}


struct Team {
    let name: String?
    let logo: String?
    let key: Int?
}
