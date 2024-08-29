//
//  FavouriteLeaguePresenter.swift
//  SportsApp
//
//  Created by Shady Adel on 29/08/2024.
//

import Foundation
import UIKit

protocol FavouriteLeagueManipulator {
    func loadLeagues(completion: ()->())
    func removeLeagueFromPersistence(_ index:Int )
    func openYouTubeLink(_ videoID: String) -> Bool
    func displayLeaguesCount() -> Int
    func displayLeaguesElement(_ index: Int) -> League
}

class FavouriteLeaguePresenter: FavouriteLeagueManipulator {
    
    var displayLeagues = [League]()
    
    func displayLeaguesCount() -> Int {
        return displayLeagues.count
    }
    
    func displayLeaguesElement(_ index: Int) -> League{
        return displayLeagues[index]
    }
    
    func loadLeagues(completion: ()->()) {
        if let leagueEntities = CoreDataManager.shared.fetchLeagues() {
            let leagues = leagueEntities.map { League(leagueName: $0.leagueName!, leagueLogo: $0.leagueLogo,leagueKey: Int32($0.leagueKey)) }
            self.displayLeagues = leagues
            completion()
        }
        
    }
    
    func removeLeagueFromPersistence(_ index:Int ){
        CoreDataManager.shared.removeLeague(displayLeagues[index])
        displayLeagues.remove(at: index)
    }
    
    func openYouTubeLink(_ videoID: String) -> Bool {
        guard let youtubeAppURL = URL(string: "youtube://\(videoID)") else {return false }
        guard let youtubeWebURL = URL(string: "https://www.youtube.com/watch?v=\(videoID)") else {return false}
        
        if UIApplication.shared.canOpenURL(youtubeAppURL) {
            UIApplication.shared.open(youtubeAppURL, options: [:], completionHandler: nil)
            return true
        } else if UIApplication.shared.canOpenURL(youtubeWebURL) {
            UIApplication.shared.open(youtubeWebURL, options: [:], completionHandler: nil)
            return true
        } else {
            return false
        }
    }
    
}
