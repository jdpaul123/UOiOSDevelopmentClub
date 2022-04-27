//
//  EventDetailViewController.swift
//  UOiOSDevelopmentClub
//
//  Created by Jonathan Paul on 8/5/21.
//

import UIKit
import EventKit
import EventKitUI

class EventDetailViewController: UIViewController, EKEventEditViewDelegate {
    func eventEditViewController(_ controller: EKEventEditViewController, didCompleteWith action: EKEventEditViewAction) {
        // Tell the app to close the delegate
        controller.dismiss(animated: true)
    }
    

    // MARK: Properties
    private let event: Event
    let viewControllerFactory: ViewControllerFactory
    let eventStore = EKEventStore()
    var time = Date()
    
    @IBOutlet var detailView: EventDetailView!
    @IBOutlet weak var editMemberButton: UIBarButtonItem!
    @IBOutlet weak var addEventToCalendarButton: UIButton!
    
    
    // MARK: Initializer
    init?(event: Event, coder: NSCoder, viewControllerFactory: ViewControllerFactory) {
        self.event = event
        self.viewControllerFactory = viewControllerFactory
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = event.title
        detailView.setEventDetailData(event: event)
    }

    @IBAction func AddEventToCalendarPressed(_ sender: Any) {
        // For adding the event to a users calendar
        eventStore.requestAccess( to: EKEntityType.event, completion:{(granted, error) in
            DispatchQueue.main.async {
                if (granted) && (error == nil) {
                    let eventToAdd = EKEvent(eventStore: self.eventStore)
                    eventToAdd.title = self.event.title
                    eventToAdd.startDate = self.event.date
                    eventToAdd.notes = self.event.about
                    eventToAdd.location = "\(self.event.location.address), \(self.event.location.city), \(self.event.location.zipCode), \(self.event.location.state)"
                    eventToAdd.endDate = self.event.date + 60 * 60 // make the end time 60 minutes
                    let eventController = EKEventEditViewController()
                    eventController.event = eventToAdd
                    eventController.eventStore = self.eventStore
                    eventController.editViewDelegate = self
                    self.present(eventController, animated: true, completion: nil)
                }
            }
        })
    }
    
    @IBSegueAction private func createEventEditViewController(_ coder: NSCoder) -> EventEditViewController? {
        return viewControllerFactory.eventEditViewController(coder, event: event)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if Injector.shared.isSignedInAsAdmin == false {
            editMemberButton.makeDisabledAndInvisable()
        }
        else {
            editMemberButton.makeEnabledAndVisable(red: 37/255, green: 150/255, blue: 190/255)
        }
    }
}
