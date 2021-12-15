//
//  Injector.swift
//  UOiOSDevelopmentClub
//
//  Created by Jonathan Paul on 8/2/21.
//

import Foundation
import CloudKit
import CoreData
import FirebaseAuth

class Injector: NSObject, NSFetchedResultsControllerDelegate {
    /*
     The injector stores all the dependencies that the app (ie. view controllers) need
     to function correctly. It also allwos for easy unit testing.
     */
    private override init() {
        viewFactory = ViewFactory()
        
        let bundle = Bundle(for: Event.self)
        let modelURL = bundle.url(forResource: "UOiOSDevelopmentClub", withExtension: "momd")!
        managedObjectModel = NSManagedObjectModel(contentsOf: modelURL)!
        persistentContainer = NSPersistentCloudKitContainer(name: "UOiOSDevelopmentClub", managedObjectModel: managedObjectModel)
        
        dataRepository = DataService(persistentContainer: persistentContainer)
        viewControllerFactory = ViewControllerFactory(viewFactory: viewFactory, dataRepository: dataRepository)
        
        
        // Base case is that they are not an admin
        isSignedInAsAdmin = false
        
        
        super.init()
        
        if Auth.auth().currentUser != nil {
            let adminResultsController = dataRepository.adminResultsController(delegate: self)
            
            // Check that there are admins in the fetched objects
            guard let adminObjects = adminResultsController?.fetchedObjects else {
                return
            }
            
            // Cycle through the admins and determine if this account is one
            for admin in adminObjects {
                if admin.email == Auth.auth().currentUser?.email {
                    isSignedInAsAdmin = true
                }
            }
        }
    }
    

    
    let dataRepository: DataRepository
    let viewFactory: ViewFactory
    static let shared = Injector()
    let viewControllerFactory: ViewControllerFactory
    
    var isSignedInAsAdmin: Bool
    
    let managedObjectModel: NSManagedObjectModel
    let persistentContainer: NSPersistentCloudKitContainer
}
