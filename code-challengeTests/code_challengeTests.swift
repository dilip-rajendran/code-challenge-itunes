//
//  code_challengeTests.swift
//  code-challengeTests
//
//  Created by Dilip on 3/24/20.
//  Copyright © 2020 Dilip. All rights reserved.
//

import XCTest
@testable import code_challenge

class code_challengeTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testResultCount() {
        let expectation = self.expectation(description: "API_Call_validation")
        var results : [resultsModel]?
        LandingScreenViewModel().getFeed { (serverResponse) in
            switch serverResponse {
            case .success(let response):
                
                if let data = response.feed?.results {
                    results = data
                    expectation.fulfill()
                }
            case .failure(let error):
                print("error: \(error.localizedDescription)")
                default: break
            }
        }
        waitForExpectations(timeout: 15, handler: nil)
        XCTAssertEqual(results?.count, 100)

    }

    func testCheckForEmptyStringValue() {
        XCTAssertEqual(AlbumResuableCellViewModel().checkForEmptyStringValue(string: ""), false)
        
        XCTAssertEqual(AlbumResuableCellViewModel().checkForEmptyStringValue(string: "hello"), true)

    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
