//
//  RootViewController.swift
//  UOiOSDevelopmentClub
//
//  Created by Jonathan Paul on 8/3/21.
//

import Foundation
import UIKit

class RootViewController: UIViewController {
    /*
     This class is for dependency injection.
     Here the viewControllerFactory of the Injector singleton is used to build a seque to the welcome tab of the application
     
     The RootViewController acts as a launching point to instantiate the view controllers
     for the rest of the application. It instantiated
     */
    @IBSegueAction private func createWelcomeViewController(_ coder: NSCoder) -> WelcomeViewController? {
        let welcomeViewController = viewControllerFactory.welcomeViewController(coder)
        return welcomeViewController
    }
    
    @IBSegueAction private func createEventsListViewController(_ coder: NSCoder) -> EventsListViewController? {
        viewControllerFactory.eventsListViewController(coder)
    }
    
    @IBSegueAction private func createMemberListViewController(_ coder: NSCoder) -> MemberListViewController? {
        viewControllerFactory.memberListViewController(coder)
    }
    
    let viewControllerFactory = Injector.shared.viewControllerFactory
}
