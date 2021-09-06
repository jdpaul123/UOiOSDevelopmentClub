//
//  DataServuce.swift
//  UOiOSDevelopmentClub
//
//  Created by Jonathan Paul on 8/5/21.
//

import Foundation
import CoreData
import UIKit

class DataService: DataRepository {
    
    func eventOrMemberEdited() {
        saveViewContext()
    }
    
    func addAdmin(email: String, uid: String) {
        let _ = Admin(email: email, uid: uid, context: persistentContainer.viewContext)
        saveViewContext()
    }
    
    func addEvent(to location: Location, title: String, about: String, date: Date, picture: Data) {
        let event = Event(title: title, about: about, date: date, picture: picture, context: persistentContainer.viewContext)
        event.location = location
        saveViewContext()
    }
    
    func addMember(about: String, position: String, email: String, phone: String, name: String, picture: Data) {
        let _ = Member(about: about, email: email, name: name, phone: phone, picture: picture, position: position, context: persistentContainer.viewContext)
        saveViewContext()
    }
    
    func addLocation(with events: [Event], address: String, city: String, country: String, state: String, zipCode: String, directionNotes: String) {
        let _ = Location(address: address, city: city, country: country, state: state, zipCode: zipCode, directionsNotes: directionNotes, context: persistentContainer.viewContext)
        saveViewContext()
    }
    
    func delete(_ admin: Admin) {
        persistentContainer.viewContext.delete(admin)
        saveViewContext()
    }
    
    func delete(_ event: Event) {
        persistentContainer.viewContext.delete(event)
        saveViewContext()
    }
    
    func delete(_ member: Member) {
        persistentContainer.viewContext.delete(member)
        saveViewContext()
    }
    
    func delete(_ location: Location) {
        persistentContainer.viewContext.delete(location)
        saveViewContext()
    }
    
    private func saveViewContext() {
        do {
            try persistentContainer.viewContext.save()
        }
        catch {
            print("Failed to save viewContext, rolling back")
            persistentContainer.viewContext.rollback()
        }
    }
    
    private func events() -> [Event] {
        let fetchRequest: NSFetchRequest = Event.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \Event.date, ascending: true)]
        return (try? persistentContainer.viewContext.fetch(fetchRequest)) ?? []
    }
    
    func adminResultsController(delegate: NSFetchedResultsControllerDelegate) -> NSFetchedResultsController<Admin>? {
        let fetchRequest: NSFetchRequest<Admin> = Admin.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \Admin.email, ascending: true)]
        fetchRequest.predicate = NSPredicate(format: "isTrashed = false")
        
        return createResultsController(for: delegate, fetchRequest: fetchRequest)
    }
    
    func eventResultsController(delegate: NSFetchedResultsControllerDelegate) -> NSFetchedResultsController<Event>? {
        /*
        let allEvents = events()
        for event in allEvents {
            let status = persistentContainer.record(for: event.objectID)
            //let status = persistentContainer.canDeleteRecord(forManagedObjectWith: event.objectID)
            if status == nil {
                persistentContainer.viewContext.performAndWait {
                    persistentContainer.viewContext.delete(event)
                    try! persistentContainer.viewContext.save()
                }
                //event.isTrashed = true
            } else {
                event.isTrashed = false
            }
        }
         // Make it so that you can swipe to delete, if you are signed into the app with an admin acount, it sets the event.isTrashed prop to true and nils out the data including the image
         */
        
        let fetchRequest: NSFetchRequest<Event> = Event.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \Event.date, ascending: true)]
        fetchRequest.predicate = NSPredicate(format: "isTrashed = false")
        
        return createResultsController(for: delegate, fetchRequest: fetchRequest)
    }
    
    func memberResultsController(delegate: NSFetchedResultsControllerDelegate) -> NSFetchedResultsController<Member>? {
        let fetchRequest: NSFetchRequest<Member> = Member.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \Member.name, ascending: true)]
        fetchRequest.predicate = NSPredicate(format: "isTrashed = false")

        return createResultsController(for: delegate, fetchRequest: fetchRequest)
    }
    
    func locationResultsController(delegate: NSFetchedResultsControllerDelegate) -> NSFetchedResultsController<Location>? {
        let fetchRequest: NSFetchRequest<Location> = Location.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \Location.address, ascending: true)]
        fetchRequest.predicate = NSPredicate(format: "isTrashed = false")

        return createResultsController(for: delegate, fetchRequest: fetchRequest)
    }
    
    private func createResultsController<T>(for delegate: NSFetchedResultsControllerDelegate, fetchRequest: NSFetchRequest<T>) -> NSFetchedResultsController<T>? where T: NSFetchRequestResult {
        let resultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        resultsController.delegate = delegate
        
        guard let _ = try? resultsController.performFetch() else {
            return nil
        }
        
        return resultsController
    }

    init(persistentContainer: NSPersistentContainer) {
        /*
         The initializer takes NSPersistentContainer instead of NSPersistentCloudKitContainer for testing purposes
         */
        self.persistentContainer = persistentContainer
        
        guard let description = self.persistentContainer.persistentStoreDescriptions.first else {
            fatalError("###\(#function): Failed to retrieve a persistent store description.")
        }
        if type(of: self.persistentContainer) == NSPersistentCloudKitContainer.self {
            description.setOption(true as NSNumber, forKey: NSPersistentHistoryTrackingKey)
            description.setOption(true as NSNumber, forKey: NSPersistentStoreRemoteChangeNotificationPostOptionKey)
            description.cloudKitContainerOptions?.databaseScope = .public
            
            // BELOW remote changes (in the cloud) are the scource of truth over what is on the phone
            persistentContainer.viewContext.automaticallyMergesChangesFromParent = true
            persistentContainer.viewContext.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
        }
        persistentContainer.loadPersistentStores { storeDescription, error in
            guard error == nil else {
                fatalError("Encountered unexpected error loading persistent stores: \(error!)")
            }
            NotificationCenter.default.post(name: .dataRepositoryInitializationFinished, object: self)
        }
    }
    
    
    // MARK: Properties
    // The initializer takes NSPersistentContainer instead of NSPersistentCloudKitContainer for testing purposes
    private let persistentContainer: NSPersistentContainer
}
