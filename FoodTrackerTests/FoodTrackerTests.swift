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
        
        //zero rating
        let zeroRatingMeal = Meal.init(name:"Zero", photo:nil, rating:0)
        XCTAssertNotNil(zeroRatingMeal)
        
        //highest positive rating
        let highestRatingMeal = Meal.init(name: "Positive", photo: nil, rating: 5)
        XCTAssertNotNil(highestRatingMeal)
    }
    
    func testMealInitializationFails(){
        //negative rating
        let negativeMealRating = Meal.init(name: "Negative", photo: nil, rating: -5)
        XCTAssertNil(negativeMealRating)
        
        
        let largeRatingMeal = Meal.init(name: "Large", photo: nil, rating: 6)
        XCTAssertNil(largeRatingMeal)
        
        let emptyStringMeal = Meal.init(name: "", photo: nil, rating: 0)
        XCTAssertNil(emptyStringMeal)
    }
    
}
