//
//  Task_FazeelTests.swift
//  Task-FazeelTests
//
//  Created by Faz on 12/4/17.
//  Copyright © 2017 Faz. All rights reserved.
//

import XCTest
@testable import Task_Fazeel


class Task_FazeelTests: XCTestCase {
    
    var currentCity = "Dubai"
    var apiKey = "d2e20dc7cb08594c288e60ef4bcf1bb6"

    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testWeather() {
       
        let weatherService = WeatherService(Apikey: apiKey)
        weatherService.getCurrentWeather(cityName: currentCity) { (result : [CurrentWeather]) in
            
            XCTAssertTrue(!result.isEmpty)
            
        }
        
    }
    
    func testPerformanceExample() {
        self.measure {
            self.testWeather()
        }
    }
    
}
