//
//  PersistentContainerHelper.swift
//  UOiOSDevelopmentClubTests
//
//  Created by Jonathan Paul on 8/14/21.
//

import CoreData
import Foundation
@testable import UOiOSDevelopmentClub

class PersistentContainerHelper {
    /*
     Using a normal NSPersistentContainer, NOT a NSPersistentCloudKitContainer as I am testing the Core Data capabilities and not the cloud aspects
     which are being handled by Apple's Cloud Kit.
     */
    func createPersistentContainer(shouldLoadStores: Bool = true) -> NSPersistentContainer {
        let storeDescription = NSPersistentStoreDescription()
        storeDescription.type = NSInMemoryStoreType
        storeDescription.shouldAddStoreAsynchronously = false
        
        let persistentContainer = NSPersistentContainer(name: "UOiOSDevelopmentClub", managedObjectModel: Injector.shared.managedObjectModel)
        persistentContainer.persistentStoreDescriptions = [storeDescription]
        
        if shouldLoadStores {
            persistentContainer.loadPersistentStores { _, error in
                guard error == nil else {
                    fatalError("Failed to load persistent stores for in memory persistent container: \(error!)")
                }
            }
        }
        return persistentContainer
    }
    
    // MARK: Properties
    static let shared = PersistentContainerHelper()
}
