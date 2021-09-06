//
//  MemberTests.swift
//  UOiOSDevelopmentClubTests
//
//  Created by Jonathan Paul on 8/15/21.
//

import Foundation
@testable import UOiOSDevelopmentClub
import XCTest
import CoreData

class MemberTests: XCTestCase {
    func testConvenienceInitializer() {
        // MARK: Data setup
        let persistentConatiner = PersistentContainerHelper.shared.createPersistentContainer()
        let member = Member(about: "Test About Message", email: "TestEmail@TestEmail.com", name: "Test Name", phone: "(TES)TPH-ONE1", picture: Data.init(), position: "Test Position", context: persistentConatiner.viewContext)
        try! persistentConatiner.viewContext.save()
        
        // MARK: Validate results
        XCTAssertEqual(member.about, "Test About Message", "Member property was unexpected")
        XCTAssertEqual(member.email, "TestEmail@TestEmail.com", "Member property was unexpected")
        XCTAssertEqual(member.name, "Test Name", "Member property was unexpected")
        XCTAssertEqual(member.phone, "(TES)TPH-ONE1", "Member property was unexpected")
        XCTAssertEqual(member.picture, Data.init(), "Member property was unexpected")
        XCTAssertEqual(member.position, "Test Position", "Member property was unexpected")
        XCTAssert(member.managedObjectContext == persistentConatiner.viewContext, "Member property was unexpected")
    }
}
