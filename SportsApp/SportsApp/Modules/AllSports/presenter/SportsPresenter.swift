//
//  SportsPresenter.swift
//  SportsApp
//
//  Created by Shady Adel on 24/08/2024.
//

import Foundation

protocol SportsArrayManipulator {
    func sportsArrayCount() -> Int
    func sportsElement(_ index: Int) -> String
}


class SportsPresenter: SportsArrayManipulator {
    
    let sportsArray = ["football","tennis", "basketball", "cricket"]
    
    
    func sportsArrayCount()->Int {
        return sportsArray.count
       
    }
    
    func sportsElement(_ index: Int) -> String {
        return sportsArray[index]
        
    }
}
