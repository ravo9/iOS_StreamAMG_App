//
//  TimeFormatterTests.swift
//  Time Formatter Tests
//
//  Created by Rafal Ozog on 10/10/2020.
//

import XCTest
@testable import StreamAMG_App

class TimeFormatterTests: XCTestCase {
    
    var timeFormatter: TimeFormatter!

    override func setUp() {
        super.setUp()
        timeFormatter = TimeFormatter()
    }

    override func tearDown() {
        timeFormatter = nil
        super.tearDown()
    }

    func testActualValueFormat() {
        
        // Prepare expected string
        let expectedTimeString = "0:02:03"

        // Perform the action
        let receivedTimeString = timeFormatter.formatTimeToDisplay(timeInSeconds: 123)

        // Check results
        XCTAssertEqual(expectedTimeString, receivedTimeString, "Formatted time string is not correct.")
    }
    
    func testNilValueFormat() {
        
        // Prepare expected string
        let expectedTimeString = "0:00:00"

        // Perform the action
        let receivedTimeString = timeFormatter.formatTimeToDisplay(timeInSeconds: nil)

        // Check results
        XCTAssertEqual(expectedTimeString, receivedTimeString, "Formatted time string is not correct.")
    }

}
