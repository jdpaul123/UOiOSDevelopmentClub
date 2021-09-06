//
//  EventDetailViewController.swift
//  UOiOSDevelopmentClub
//
//  Created by Jonathan Paul on 8/5/21.
//

import UIKit

class EventDetailViewController: UIViewController {


    // MARK: Properties
    private let event: Event
    let viewControllerFactory: ViewControllerFactory
    
    @IBOutlet var detailView: EventDetailView!
    @IBOutlet weak var editMemberButton: UIBarButtonItem!
    
    
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
