//
//  FoodTrackerTests.swift
//  FoodTrackerTests
//
//  Created by Leo Liu on 7/17/17.
//  Copyright © 2017 Blue Anchor. All rights reserved.
//

import XCTest
@testable import FoodTracker

class FoodTrackerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    //MARK: Meal Class Tests
    func testMealInitializationSucceeds(){
        let zeroRatingMeal = Meal.init(name:"Zero", photo:nil, rating:0);
        XCTAssertNotNil(zeroRatingMeal);
    }
    
}
