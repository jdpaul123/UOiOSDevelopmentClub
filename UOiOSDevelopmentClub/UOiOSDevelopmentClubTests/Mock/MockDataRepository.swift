//
//  MockDataRepository.swift
//  UOiOSDevelopmentClubTests
//
//  Created by Jonathan Paul on 8/13/21.
//

import CoreData
import Foundation
@testable import UOiOSDevelopmentClub

class MockDataRepository: DataRepository {
    func addEvent(to location: Location, title: String, about: String, date: Date, picture: Data) {
        addEventHandler?(location, title, about, date, picture)
    }
    
    func addMember(about: String, position: String, email: String, phone: String, name: String, picture: Data) {
        addMembersHandler?(about, position, email, phone, name, picture)
    }
    
    func addLocation(with events: [Event], address: String, city: String, country: String, state: String, zipCode: String, directionNotes: String) {
        addLocationHandler?(address, city, country, state, zipCode, directionNotes)
    }
    
    func delete(_ event: Event) {
        deleteEvent?(event)
    }
    
    func delete(_ member: Member) {
        deleteMember?(member)
    }
    
    func delete(_ location: Location) {
        deleteLocation?(location)
    }
    
    func eventResultsController(delegate: NSFetchedResultsControllerDelegate) -> NSFetchedResultsController<Event>? {
        eventResultsControllerHandler?(delegate)
    }
    
    func memberResultsController(delegate: NSFetchedResultsControllerDelegate) -> NSFetchedResultsController<Member>? {
        memberResultsControllerHandler?(delegate)
    }
    
    func locationResultsController(delegate: NSFetchedResultsControllerDelegate) -> NSFetchedResultsController<Location>? {
        locationResultsControllerHandler?(delegate)
    }
    
    // MARK: Properties
    var addEventHandler: ((Location, String, String, Date, Data) -> Void)?
    var addMembersHandler: ((String, String, String, String, String, Data) -> Void)?
    var addLocationHandler: ((String, String, String, String, String, String)->Void)?
    
    var deleteEvent: ((Event) -> Void)?
    var deleteMember: ((Member) -> Void)?
    var deleteLocation: ((Location) -> Void)?
    
    var eventResultsControllerHandler: ((NSFetchedResultsControllerDelegate) -> NSFetchedResultsController<Event>?)?
    var memberResultsControllerHandler: ((NSFetchedResultsControllerDelegate) -> NSFetchedResultsController<Member>?)?
    var locationResultsControllerHandler: ((NSFetchedResultsControllerDelegate) -> NSFetchedResultsController<Location>?)?
    
}
