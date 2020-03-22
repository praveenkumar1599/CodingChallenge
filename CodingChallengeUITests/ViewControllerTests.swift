//
//  ViewControllerTests.swift
//  CodingChallengeUITests
//
//  Created by Praveen on 3/20/20.
//

import XCTest

class ViewControllerTests: XCTestCase {
    private var app: XCUIApplication!
    var vc = ViewController()
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        app = XCUIApplication()
        app.launch()
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testTableViewData() {
        let expectation = self.expectation(description: "executed")
        vc.viewDidLoad()
        vc.homeVCModel.getDataFromAPI(complete: { isSuccess in
            XCTAssertTrue(isSuccess == true, "we should not get success response")
            XCTAssertTrue(!self.vc.homeVCModel.dataArray.isEmpty, "dataArray list should have data")
            DispatchQueue.main.async {
                XCTAssertEqual(self.vc.tableView(UITableView(), numberOfRowsInSection: 0), self.vc.homeVCModel.dataArray.count)
                if let firstCell = self.vc.tableView(self.vc.homeTableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? CustomTableViewCell {
                    XCTAssertEqual(firstCell.albumName.text, self.vc.homeVCModel.dataArray[0].name)
                    XCTAssertEqual(firstCell.artistName.text, self.vc.homeVCModel.dataArray[0].artistName)
                }
            }
            expectation.fulfill()
        })
        self.waitForExpectations(timeout: 10, handler: nil)
    }
    
}
