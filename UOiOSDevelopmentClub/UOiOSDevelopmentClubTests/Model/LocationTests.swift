//
//  LocationTests.swift
//  UOiOSDevelopmentClubTests
//
//  Created by Jonathan Paul on 8/15/21.
//

import Foundation
@testable import UOiOSDevelopmentClub
import XCTest
import CoreData

class LocationTests: XCTestCase {
    func testConvenienceInitializer() {
        // MARK: Data Setup
        let persistentConatiner = PersistentContainerHelper.shared.createPersistentContainer()
        let location = Location(address: "Test Address", city: "Test City", country: "Test Country", state: "Test State", zipCode: "Test Zip Code", directionsNotes: "Test Directions", context: persistentConatiner.viewContext)
        try! persistentConatiner.viewContext.save()
        
        // MARK: Validate results
        XCTAssertEqual(location.address, "Test Address", "Location property was unexpected")
        XCTAssertEqual(location.city, "Test City", "Location property was unexpected")
        XCTAssertEqual(location.country, "Test Country", "Location property was unexpected")
        XCTAssertEqual(location.state, "Test State", "Location property was unexpected")
        XCTAssertEqual(location.zipCode, "Test Zip Code", "Location property was unexpected")
        XCTAssertEqual(location.directionsNotes, "Test Directions", "Location property was unexpected")
        XCTAssert(location.managedObjectContext == persistentConatiner.viewContext, "Location property was unexpected")
    }
}
