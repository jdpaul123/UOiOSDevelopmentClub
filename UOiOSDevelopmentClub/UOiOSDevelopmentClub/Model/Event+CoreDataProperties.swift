//
//  Event+CoreDataProperties.swift
//  UOiOSDevelopmentClub
//
//  Created by Jonathan Paul on 8/5/21.
//
//

import Foundation
import CoreData


extension Event {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Event> {
        return NSFetchRequest<Event>(entityName: "Event")
    }

    @NSManaged public var about: String
    @NSManaged public var date: Date
    @NSManaged public var picture: Data?
    @NSManaged public var location: Location
    @NSManaged public var title: String
    @NSManaged public var isTrashed: Bool

}

extension Event : Identifiable {

}
