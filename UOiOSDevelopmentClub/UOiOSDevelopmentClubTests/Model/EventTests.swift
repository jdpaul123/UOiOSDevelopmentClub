//
//  EventTests.swift
//  UOiOSDevelopmentClubTests
//
//  Created by Jonathan Paul on 8/15/21.
//

import Foundation
@testable import UOiOSDevelopmentClub
import XCTest
import CoreData

class EventTests: XCTestCase {
    func testConvenienveInitializer() {
        func testConvenienceInitializer() {
            // MARK: Data Setup
            let persistentConatiner = PersistentContainerHelper.shared.createPersistentContainer()
            let event = Event(title: "Test Title", about: "Test About", date: Date.init(), picture: Data.init(), context: persistentConatiner.viewContext)
            try! persistentConatiner.viewContext.save()
            
            // MARK: Validate results
            XCTAssertEqual(event.title, "Test Title", "Event property was unexpected")
            XCTAssertEqual(event.about, "Test About", "Event property was unexpected")
            XCTAssertEqual(event.date, Date.init(), "Event property was unexpected")
            XCTAssertEqual(event.picture, Data.init(), "Event property was unexpected")
            XCTAssert(event.managedObjectContext == persistentConatiner.viewContext, "Event property was unexpected")
        }
    }
}
