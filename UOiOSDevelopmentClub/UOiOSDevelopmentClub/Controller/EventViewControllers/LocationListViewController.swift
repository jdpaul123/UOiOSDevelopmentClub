//
//  LocationListViewController.swift
//  UOiOSDevelopmentClub
//
//  Created by Jonathan Paul on 4/13/22.
//

import UIKit
import CoreData

class LocationListViewController: UITableViewController , NSFetchedResultsControllerDelegate {
    // MARK: Properties
    let dataRepository: DataRepository
    let viewControllerFactory: ViewControllerFactory
    var resultsController: NSFetchedResultsController<Location>? = nil

    // Label for when we are loading in data
    let loadingLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init?(_ coder: NSCoder, dataRepository: DataRepository, viewControllerFactory: ViewControllerFactory) {
        self.dataRepository = dataRepository
        self.viewControllerFactory = viewControllerFactory
       
        super.init(coder: coder)
        resultsController = dataRepository.locationResultsController(delegate: self)
    }
    
    
    @IBSegueAction private func createLocationEditViewController(_ coder: NSCoder) -> LocationEditViewController? {
        guard let selectedIndexPath = tableView.indexPathForSelectedRow, let location = resultsController?.object(at: selectedIndexPath) else {
            print(" Error ")
            return nil
        }
        tableView.deselectRow(at: selectedIndexPath, animated: true)

        return viewControllerFactory.locationEditViewController(coder, location: location)
    }
    
    @IBSegueAction private func createLocationAddViewController(_ coder: NSCoder) -> LocationAddViewController? {
        viewControllerFactory.locationAddViewController(coder)
    }
    
    
    // DONT need the below two sections because it comes implicitly with the fact that this calss conforms to UITableViewController
    // MARK: UITableViewDataSource Functions
    override func numberOfSections(in tableView: UITableView) -> Int {
        return resultsController?.sections?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultsController?.sections?[section].numberOfObjects ?? 0
    }
    
    // MARK: UITableViewDelegate Function
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Tell the section how many events we have
        // Verify that the count if greater than zero if this does not work when you run the application
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "locationCell", for: indexPath) as! LocationListCell
        
        // Use force unwrap because you already know that this exists based on using events in numberOfsections. So here you would want to know if it did not work.
        let location = resultsController!.object(at: indexPath)
        
        cell.setCellData(location: location)
        
        // Get rid of loading label because everything is loaded
        loadingLabel.removeFromSuperview()
        
        return cell
    }
    
}
