//
//  Admin+CoreDataClass.swift
//  
//
//  Created by Jonathan Paul on 9/3/21.
//
//

import Foundation
import CoreData


public class Admin: NSManagedObject {
    convenience init (email: String, uid: String, context: NSManagedObjectContext) {
        self.init(context: context)
        
        self.email = email
        self.uid = uid
    }
}
