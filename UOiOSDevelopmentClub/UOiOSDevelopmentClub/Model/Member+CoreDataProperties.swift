//
//  Member+CoreDataProperties.swift
//  UOiOSDevelopmentClub
//
//  Created by Jonathan Paul on 8/5/21.
//
//

import Foundation
import CoreData


extension Member {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Member> {
        return NSFetchRequest<Member>(entityName: "Member")
    }

    @NSManaged public var about: String
    @NSManaged public var email: String
    @NSManaged public var name: String
    @NSManaged public var phone: String
    @NSManaged public var picture: Data
    @NSManaged public var position: String
    @NSManaged public var isTrashed: Bool


}

extension Member : Identifiable {

}
