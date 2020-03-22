//
//  HomeVCModelTests.swift
//  CodingChallengeTests
//
//  Created by Praveen on 3/20/20.
//

import XCTest

class HomeVCModelTests: XCTestCase {
    let homeViewModel = HomeVCModel()
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testGetDatFromAPI_WithValidURL() {
        var expectation: XCTestExpectation? = self.expectation(description: "executed")
        homeViewModel.baseURL = "https://rss.itunes.apple.com/api/v1/us/apple-music/coming-soon/all/100/explicit.json"
        DispatchQueue.main.async {
            self.homeViewModel.getDataFromAPI(complete: { isSuccess in
                XCTAssertTrue(isSuccess == true, "we should get success response")
                XCTAssertTrue(!self.homeViewModel.dataArray.isEmpty, "dataArray list should have data")
                expectation?.fulfill()
                expectation = nil
                
            })
        }

        self.waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testGetDatFromAPI_inValidURL() {
        let expectation = self.expectation(description: "executed")
        homeViewModel.baseURL = "https://rss.itunes.apple.com/api/v1/us/apple-music/coming-soon/all/100/explicit"
        homeViewModel.getDataFromAPI(complete: { isSuccess in
            XCTAssertTrue(isSuccess == false, "we should not get success response")
            XCTAssertTrue(self.homeViewModel.dataArray.isEmpty, "dataArray list should have nil")
            expectation.fulfill()
        })
        self.waitForExpectations(timeout: 10, handler: nil)
    }
}
