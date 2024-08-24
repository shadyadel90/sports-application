//
//  SportsPresenter.swift
//  SportsApp
//
//  Created by Shady Adel on 24/08/2024.
//

import Foundation

class SportsPresenter {
    let sportsArray = ["football","tennis", "basketball", "cricket"]
    
    
    func sportsArrayCount()->Int {
        return sportsArray.count
    }
    
    func sportsElement(_ index: Int) -> String {
        return sportsArray[index]
    }
}
