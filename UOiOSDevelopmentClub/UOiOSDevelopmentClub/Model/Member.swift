//
//  Member+CoreDataClass.swift
//  UOiOSDevelopmentClub
//
//  Created by Jonathan Paul on 8/5/21.
//
//

import Foundation
import CoreData


public class Member: NSManagedObject {
    convenience init(about: String, email: String, name: String, phone: String, picture: Data, position: String, context: NSManagedObjectContext) {
        self.init(context: context)
        self.about = about
        self.email = email
        self.name = name
        self.phone = phone
        self.picture = picture
        self.position = position
    }
}
