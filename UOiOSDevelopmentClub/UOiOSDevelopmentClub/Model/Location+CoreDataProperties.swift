//
//  Location+CoreDataProperties.swift
//  UOiOSDevelopmentClub
//
//  Created by Jonathan Paul on 8/5/21.
//
//

import Foundation
import CoreData


extension Location {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Location> {
        return NSFetchRequest<Location>(entityName: "Location")
    }

    @NSManaged public var address: String
    @NSManaged public var city: String
    @NSManaged public var country: String
    @NSManaged public var state: String
    @NSManaged public var zipCode: String
    @NSManaged public var directionsNotes: String
    @NSManaged public var event: NSSet
    @NSManaged public var isTrashed: Bool

}

// MARK: Generated accessors for event
extension Location {

    @objc(addEventObject:)
    @NSManaged public func addToEvent(_ value: Event)

    @objc(removeEventObject:)
    @NSManaged public func removeFromEvent(_ value: Event)

    @objc(addEvent:)
    @NSManaged public func addToEvent(_ values: NSSet)

    @objc(removeEvent:)
    @NSManaged public func removeFromEvent(_ values: NSSet)

}

extension Location : Identifiable {

}
