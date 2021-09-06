//
//  Admin+CoreDataProperties.swift
//  
//
//  Created by Jonathan Paul on 9/3/21.
//
//

import Foundation
import CoreData


extension Admin {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Admin> {
        return NSFetchRequest<Admin>(entityName: "Admin")
    }

    @NSManaged public var email: String
    @NSManaged public var uid: String
    @NSManaged public var isTrashed: Bool

}
