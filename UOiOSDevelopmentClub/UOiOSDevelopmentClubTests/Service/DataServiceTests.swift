//
//  DataServiceTests.swift
//  UOiOSDevelopmentClubTests
//
//  Created by Jonathan Paul on 8/15/21.
//

import CoreData
import Foundation
@testable import UOiOSDevelopmentClub
import XCTest

class DataServiceTests: XCTestCase {
    // MARK: Test Life Cycle
    override func setUp() {
        persistentContainer = PersistentContainerHelper.shared.createPersistentContainer(shouldLoadStores: false)
        dataService = DataService(persistentContainer: persistentContainer)
        
        //let _ = expectation(forNotification: .dataRepositoryInitializationFinished, object: dataService)
        //waitForExpectations(timeout: 1)
    }
    
    override func tearDown() {
        dataService = nil
        persistentContainer = nil
    }

    
    // MARK: Properties
    var persistentContainer: NSPersistentContainer!
    var dataService: DataService!
    
    // MARK: Tests
    func testAddMember() throws {
        dataService.addMember(about: "Test About Message", position: "Test Position", email: "TestEmail@TestEmail.com", phone: "(TES)TPH-ONE1", name: "Test Name", picture: Data.init())

        // Validate results
        let fetchRequest: NSFetchRequest<Member> = Member.fetchRequest()
        let context = persistentContainer.newBackgroundContext()
        context.perform {
            guard let allMember = try? context.fetch(fetchRequest) else {
                XCTFail("Failed to fetch the members after adding a member object")
                return
            }
            XCTAssertEqual(allMember.count, 1)
            let fetchedMember = allMember[0]
            XCTAssertEqual(fetchedMember.name, "Test Name")
        }

    }

    func testDeleteMember() throws {
        let member = Member(about: "Test About Message", email: "TestEmail@TestEmail.com", name: "Test Name", phone: "(TES)TPH-ONE1", picture: Data.init(), position: "Test Position", context: persistentContainer.viewContext)
        try persistentContainer.viewContext.save()
        
        // Perform task
        dataService.delete(member)
        
        // Validate results
        let fetchRequest : NSFetchRequest<Member> = Member.fetchRequest()
        let context = persistentContainer.newBackgroundContext()
        context.perform {
            guard let allProject = try? context.fetch(fetchRequest) else {
                XCTFail("Failed to fetch members after adding a member object")
                return
            }
            
            XCTAssertEqual(allProject.count, 0, "Member count was not 0 after deleting the test project object")
        }
    }

    func testAddLocation() throws {
        dataService.addLocation(with: [], address: "Test Address", city: "Test City", country: "Test Country", state: "Test State", zipCode: "Test Zip Code", directionNotes: "Test Directions")

        // Validate results
        let fetchRequest: NSFetchRequest<Location> = Location.fetchRequest()
        let context = persistentContainer.newBackgroundContext()
        context.perform {
            guard let allLocation = try? context.fetch(fetchRequest) else {
                XCTFail("Failed to fetch the members after adding a project object")
                return
            }
            XCTAssertEqual(allLocation.count, 1)
            let fetchedLocation = allLocation[0]
            XCTAssertEqual(fetchedLocation.address, "Test Address")
        }
    }

    func testDeleteLocation() throws {
        let location = Location(address: "Test Address", city: "Test City", country: "Test Country", state: "Test State", zipCode: "Test Zip Code", directionsNotes: "Test Directions", context: persistentContainer.viewContext)
        try persistentContainer.viewContext.save()
        
        // Perform task
        dataService.delete(location)
        
        // Validate results
        let fetchRequest : NSFetchRequest<Location> = Location.fetchRequest()
        let context = persistentContainer.newBackgroundContext()
        context.perform {
            guard let allLocation = try? context.fetch(fetchRequest) else {
                XCTFail("Failed to fetch locations after adding a location object")
                return
            }
            
            XCTAssertEqual(allLocation.count, 0, "Location count was not 0 after deleting the test location object")
        }
    }

    func testAddEvent() throws {
        dataService.addEvent(to: Location.init(), title: "Test Title", about: "Test About", date: Date.init(), picture: Data.init())
        // Validate results
        let fetchRequest: NSFetchRequest<Event> = Event.fetchRequest()
        let context = persistentContainer.newBackgroundContext()
        context.perform {
            guard let allEvent = try? context.fetch(fetchRequest) else {
                XCTFail("Failed to fetch the members after adding a project object")
                return
            }
            XCTAssertEqual(allEvent.count, 1)
            let fetchedEvent = allEvent[0]
            XCTAssertEqual(fetchedEvent.title, "Test Title")
        }
    }

    func testDeleteEvent() throws {
        let event = Event(title: "Test Title", about: "Test About", date: Date.init(), picture: Data.init(), context: persistentContainer.viewContext)
        try persistentContainer.viewContext.save()
        
        // Perform task
        dataService.delete(event)
        
        // Validate results
        let fetchRequest : NSFetchRequest<Event> = Event.fetchRequest()
        let context = persistentContainer.newBackgroundContext()
        context.perform {
            guard let allEvent = try? context.fetch(fetchRequest) else {
                XCTFail("Failed to fetch events after adding an event object")
                return
            }
            
            XCTAssertEqual(allEvent.count, 0, "Event count was not 0 after deleting the test event object")
        }
    }
    
    func testMemberResultsControler() throws {
        // Your test should validate that the service produces a fetched results controller with the correct delegate that has the expected objects sorted by their name value.
        
        // Setup test data
        let delegate = MockNSFetchedResultsControllerDelegate()
        let _ = Member(about: "Test About Message", email: "TestEmail@TestEmail.com", name: "Test Name", phone: "(TES)TPH-ONE1", picture: Data.init(), position: "Test Position", context: persistentContainer.viewContext)
        let _ = Member(about: "Test About Message", email: "TestEmail@TestEmail.com", name: "Test Name", phone: "(TES)TPH-ONE1", picture: Data.init(), position: "Test Position", context: persistentContainer.viewContext)
        let _ = Member(about: "Test About Message", email: "TestEmail@TestEmail.com", name: "Test Name", phone: "(TES)TPH-ONE1", picture: Data.init(), position: "Test Position", context: persistentContainer.viewContext)
        let _ = Member(about: "Test About Message", email: "TestEmail@TestEmail.com", name: "Test Name", phone: "(TES)TPH-ONE1", picture: Data.init(), position: "Test Position", context: persistentContainer.viewContext)
        try persistentContainer.viewContext.save()
        
        let resultsController = dataService.memberResultsController(delegate: delegate)
        
        XCTAssertTrue(resultsController?.delegate === delegate, "Results controller delegate was unexpected instance")
        
        guard let resultsControllerProjects = resultsController!.fetchedObjects else {
            XCTFail("Results controoller projects were nil")
            return
        }
        
        let fetchRequest: NSFetchRequest<Member> = Member.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \Member.name, ascending: true)]
        let fetchedResults = try! persistentContainer.viewContext.fetch(fetchRequest)
        
        XCTAssertEqual(resultsControllerProjects.count, fetchedResults.count, "Member results conroller count did not match fetched results count")
        for (index, fetchedProject) in fetchedResults.enumerated() {
            XCTAssertEqual(resultsControllerProjects[index].name, fetchedProject.name, "Unexpected object sort in member results controller objects")
        }
    }
    
    func testLocationResultsController() throws {
        // Your test should validate that the service produces a fetched results controller with the correct delegate that has the expected objects sorted by their name value.
        
        // Setup test data
        let delegate = MockNSFetchedResultsControllerDelegate()
        let _ = Location(address: "Test Address", city: "Test City", country: "Test Country", state: "Test State", zipCode: "Test Zip Code", directionsNotes: "Test Directions", context: persistentContainer.viewContext)
        let _ = Location(address: "Test Address", city: "Test City", country: "Test Country", state: "Test State", zipCode: "Test Zip Code", directionsNotes: "Test Directions", context: persistentContainer.viewContext)
        let _ = Location(address: "Test Address", city: "Test City", country: "Test Country", state: "Test State", zipCode: "Test Zip Code", directionsNotes: "Test Directions", context: persistentContainer.viewContext)
        let _ = Location(address: "Test Address", city: "Test City", country: "Test Country", state: "Test State", zipCode: "Test Zip Code", directionsNotes: "Test Directions", context: persistentContainer.viewContext)
        try persistentContainer.viewContext.save()
        
        let resultsController = dataService.locationResultsController(delegate: delegate)
        
        XCTAssertTrue(resultsController?.delegate === delegate, "Results controller delegate was unexpected instance")
        
        guard let resultsControllerProjects = resultsController!.fetchedObjects else {
            XCTFail("Results controller locations were nil")
            return
        }
        
        let fetchRequest: NSFetchRequest<Location> = Location.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \Location.address, ascending: true)]
        let fetchedResults = try! persistentContainer.viewContext.fetch(fetchRequest)
        
        XCTAssertEqual(resultsControllerProjects.count, fetchedResults.count, "Location results conroller count did not match fetched results count")
        for (index, fetchedProject) in fetchedResults.enumerated() {
            XCTAssertEqual(resultsControllerProjects[index].address, fetchedProject.address, "Unexpected object sort in location results controller objects")
        }
    }
    
    func testEventResultsController() throws {
        // Your test should validate that the service produces a fetched results controller with the correct delegate that has the expected objects sorted by their name value.
        
        // Setup test data
        let delegate = MockNSFetchedResultsControllerDelegate()
        let _ = Event(title: "Test Title", about: "Test About", date: Date.init(), picture: Data.init(), context: persistentContainer.viewContext)
        let _ = Event(title: "Test Title", about: "Test About", date: Date.init(), picture: Data.init(), context: persistentContainer.viewContext)
        let _ = Event(title: "Test Title", about: "Test About", date: Date.init(), picture: Data.init(), context: persistentContainer.viewContext)
        let _ = Event(title: "Test Title", about: "Test About", date: Date.init(), picture: Data.init(), context: persistentContainer.viewContext)
        try persistentContainer.viewContext.save()
        
        let resultsController = dataService.eventResultsController(delegate: delegate)
        
        XCTAssertTrue(resultsController?.delegate === delegate, "Results controller delegate was unexpected instance")
        
        guard let resultsControllerProjects = resultsController!.fetchedObjects else {
            XCTFail("Results controller locations were nil")
            return
        }
        
        let fetchRequest: NSFetchRequest<Event> = Event.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \Event.title, ascending: true)]
        let fetchedResults = try! persistentContainer.viewContext.fetch(fetchRequest)
        
        XCTAssertEqual(resultsControllerProjects.count, fetchedResults.count, "Event results conroller count did not match fetched results count")
        for (index, fetchedProject) in fetchedResults.enumerated() {
            XCTAssertEqual(resultsControllerProjects[index].title, fetchedProject.title, "Unexpected object sort in event results controller objects")
        }
    }
}
