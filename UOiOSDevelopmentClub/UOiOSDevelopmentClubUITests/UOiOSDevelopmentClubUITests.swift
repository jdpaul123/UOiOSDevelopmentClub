//
//  UOiOSDevelopmentClubUITests.swift
//  UOiOSDevelopmentClubUITests
//
//  Created by Jonathan Paul on 8/2/21.
//

import XCTest

class UOiOSDevelopmentClubUITests: XCTestCase {
    // MARK: NOTE FOR GRADER: Not too much to test for the UI right now as adding deleting and editing data is not part of my proposal and will be implimented in the comming weeks

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
        let app = XCUIApplication()
        app.launch()

        XCTAssertTrue(app.wait(for: .runningForeground, timeout: 1), "The application did not reach the runningForeground state")
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAccessEventDetails() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        app.tabBars["Tab Bar"].buttons["Events"].tap()
        
        let eventList = app.tables["event-tableview"]
        XCTAssertEqual(eventList.exists, true, "Could not find event list")
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testAccessMembers() throws {
        let app = XCUIApplication()
        app.launch()
        app.tabBars["Tab Bar"].buttons["Executives/Advisors"].tap()
        
        let membersList = app.tables["members-tableview"]
        XCTAssertEqual(membersList.exists, true, "Could not find event list")
    }
//    func testLaunchPerformance() throws {
//        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
//            // This measures how long it takes to launch your application.
//            measure(metrics: [XCTApplicationLaunchMetric()]) {
//                XCUIApplication().launch()
//            }
//        }
//    }
}
