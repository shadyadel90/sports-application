//
//  FavouriteLeaguesTests.swift
//  SportsAppTests
//
//  Created by Shady Adel on 31/08/2024.
//

import XCTest
@testable import SportsApp

final class FavouriteLeaguesTests: XCTestCase {

    override func setUpWithError() throws {
        
    }

    override func tearDownWithError() throws {
       
    }
    
    let presenter = FavouriteLeaguePresenter()

    
    func testLoadLeagues() {
           let expectation = self.expectation(description: "Leagues loaded")
           
           presenter.loadLeagues {
               expectation.fulfill()
           }
           
           waitForExpectations(timeout: 1, handler: nil)
        
       }
    
    func testOpenYouTubeLink() {
            let validVideoID = "k4MNDLU9ejQ"
            XCTAssertTrue(presenter.openYouTubeLink(validVideoID), "Should be able to open a valid YouTube link")
        
        
            //FIXME: fix invalid url should return false
            let invalidVideoID = ""
            XCTAssertFalse(presenter.openYouTubeLink(invalidVideoID), "Should not be able to open an invalid YouTube link")
        }
   

}
