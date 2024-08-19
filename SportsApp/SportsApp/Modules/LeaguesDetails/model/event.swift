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
    
    enum CodingKeys: String, CodingKey {
        case home = "event_home_team"
        case away = "event_away_team"
        case date = "event_date"
        case time = "event_time"
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
