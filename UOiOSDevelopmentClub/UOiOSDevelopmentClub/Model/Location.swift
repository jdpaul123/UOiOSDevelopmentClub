//
//  Location+CoreDataClass.swift
//  UOiOSDevelopmentClub
//
//  Created by Jonathan Paul on 8/5/21.
//
//

import Foundation
import CoreData


public class Location: NSManagedObject {
    convenience init(address: String, city: String, country: String, state: String, zipCode: String, directionsNotes: String, context: NSManagedObjectContext) {
        self.init(context: context)
        
        self.address = address
        self.city = city
        self.country = country
        self.state = state
        self.zipCode = zipCode
        self.directionsNotes = directionsNotes
    }
}
