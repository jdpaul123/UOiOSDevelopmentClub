//
//  EventsViewControler.swift
//  UOiOSDevelopmentClub
//
//  Created by Jonathan Paul on 8/5/21.
//

import UIKit
import CoreData
import FirebaseAuth

class EventsListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate {
    // MARK: Properties
    @IBOutlet weak var addMemberButton: UIBarButtonItem!
    let viewControllerFactory: ViewControllerFactory
    @IBOutlet private weak var tableView: UITableView!
    var resultsController: NSFetchedResultsController<Event>? = nil
    let dataRepository: DataRepository
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init?(_ coder: NSCoder, dataRepository: DataRepository, viewControllerFactory: ViewControllerFactory) {
        self.dataRepository = dataRepository
        self.viewControllerFactory = viewControllerFactory
       
        super.init(coder: coder)
        resultsController = dataRepository.eventResultsController(delegate: self)
    }
    
    // MARK: IBSequeAction
    @IBSegueAction private func createEventDetailViewController(_ coder: NSCoder) -> EventDetailViewController? {
        guard let selectedIndexPath = tableView.indexPathForSelectedRow, let event = resultsController?.object(at: selectedIndexPath) else {
            print(" Error ")
            return nil
        }
        tableView.deselectRow(at: selectedIndexPath, animated: true)

        return viewControllerFactory.eventDetailViewController(coder, event: event)
    }
    
    @IBSegueAction private func createEventAddViewController(_ coder: NSCoder) -> EventAddViewController? {
        viewControllerFactory.eventAddViewController(coder)
    }
    
    // MARK: UITableViewDataSource Functions
    func numberOfSections(in tableView: UITableView) -> Int {
        return resultsController?.sections?.count ?? 0
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultsController?.sections?[section].numberOfObjects ?? 0
    }
    
    // MARK: UITableViewDelegate Function
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Tell the section how many events we have
        // Verify that the count if greater than zero if this does not work when you run the application
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "eventCell", for: indexPath) as! EventListCell
        
        // Use force unwrap because you already know that this exists based on using events in numberOfsections. So here you would want to know if it did not work.
        let event = resultsController!.object(at: indexPath)
        
        cell.setCellData(event: event)
        return cell
    }
    
    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundColor = UIColor(.black)
        
        // Gets rid of extra horizontal lines after the last cell in the table view
        tableView.tableFooterView = UIView(frame: .zero)
        
        tableView.accessibilityIdentifier = "event-tableview"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if Injector.shared.isSignedInAsAdmin == false {
            addMemberButton.makeDisabledAndInvisable()
        }
        else {
            addMemberButton.makeEnabledAndVisable(red: 37/255, green: 150/255, blue: 190/255)
        }
    }
}
