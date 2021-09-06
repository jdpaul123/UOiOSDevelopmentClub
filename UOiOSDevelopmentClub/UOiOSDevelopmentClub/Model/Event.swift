//
//  Event+CoreDataClass.swift
//  UOiOSDevelopmentClub
//
//  Created by Jonathan Paul on 8/5/21.
//
//

import Foundation
import CoreData


public class Event: NSManagedObject {
    convenience init(title: String, about: String, date: Date, picture: Data, context: NSManagedObjectContext) {
        self.init(context: context)
        self.title = title
        self.about = about
        self.date = date
        self.picture = picture
    }
}
