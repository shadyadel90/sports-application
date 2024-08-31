//
//  SportsAppTests.swift
//  SportsAppTests
//
//  Created by Shady Adel on 23/08/2024.
//

import XCTest
@testable import SportsApp

final class SportsAppTests: XCTestCase {
    
    override func setUpWithError() throws {
        
    }
    
    override func tearDownWithError() throws {
    }
    
    func testPresenter() {
        
        let presenter = SportsPresenter()
        
        XCTAssertEqual(4, presenter.sportsArrayCount())
        
        XCTAssertEqual(presenter.sportsElement(4), "")
        
        
        
    }
    
    
}
