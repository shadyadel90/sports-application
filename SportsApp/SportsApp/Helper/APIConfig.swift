//
//  APIConfig.swift
//  SportsApp
//

import Foundation

enum APIConfig {
    /// Set `ALLSPORTS_API_KEY` in the Xcode scheme environment variables.
    static var allSportsAPIKey: String {
        ProcessInfo.processInfo.environment["ALLSPORTS_API_KEY"] ?? ""
    }
}
