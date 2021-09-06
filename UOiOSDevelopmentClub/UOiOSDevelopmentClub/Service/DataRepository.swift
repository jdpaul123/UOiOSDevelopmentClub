//
//  eventRepository.swift
//  UOiOSDevelopmentClub
//
//  Created by Jonathan Paul on 8/5/21.
//

import Foundation
import CoreData

protocol DataRepository {
    func eventOrMemberEdited()
    
    func addAdmin(email: String, uid: String)

    func addEvent(to location: Location, title: String, about: String, date: Date, picture: Data)
    
    func addMember(about: String, position: String, email: String, phone: String, name: String, picture: Data)

    func addLocation(with events: [Event], address: String, city: String, country: String, state: String, zipCode: String, directionNotes: String)

    func delete(_ admin: Admin)

    func delete(_ event: Event)
    
    func delete(_ member: Member)
    
    func delete(_ location: Location)
    
    func adminResultsController(delegate: NSFetchedResultsControllerDelegate) -> NSFetchedResultsController<Admin>?
    
    func eventResultsController(delegate: NSFetchedResultsControllerDelegate) -> NSFetchedResultsController<Event>?

    func memberResultsController(delegate: NSFetchedResultsControllerDelegate) -> NSFetchedResultsController<Member>?

    func locationResultsController(delegate: NSFetchedResultsControllerDelegate) -> NSFetchedResultsController<Location>?
}
