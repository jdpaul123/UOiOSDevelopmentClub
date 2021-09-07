//
//  ViewControllerFactory.swift
//  UOiOSDevelopmentClub
//
//  Created by Jonathan Paul on 8/3/21.
//

import Foundation

class ViewControllerFactory {
    /*
     Used for implimentation of dependency injection,
     THis file holds a reference to the dependencies initialized in the injector which is then used to
     instantiate new view controllers.
     */
    
    init(viewFactory: ViewFactory, dataRepository: DataRepository) {
        self.viewFactory = viewFactory
        self.dataRepository = dataRepository
    }
    
    func rootViewContoller(_ coder: NSCoder) -> RootViewController? {
        RootViewController(coder: coder)
    }
    
    func pickSignInOptionViewController(_ coder: NSCoder) -> PickSignInOptionViewController? {
        PickSignInOptionViewController(viewControllerFactory: self, coder: coder)
    }
    
    func logInViewController(_ coder: NSCoder) -> LogInViewController? {
        LogInViewController(dataRepository: dataRepository, coder: coder)
    }
    
    func welcomeViewController(_ coder: NSCoder) -> WelcomeViewController? {
        WelcomeViewController(viewFactory: viewFactory, viewControllerFactory: self,coder: coder)
    }
    
    func eventsListViewController(_ coder: NSCoder) -> EventsListViewController? {
        EventsListViewController(coder, dataRepository: dataRepository, viewControllerFactory: self)
    }
    
    func eventDetailViewController(_ coder: NSCoder, event: Event) -> EventDetailViewController? {
        EventDetailViewController(event: event, coder: coder, viewControllerFactory: self)
    }
    
    func eventAddViewController(_ coder: NSCoder) -> EventAddViewController? {
        EventAddViewController(coder: coder, dataRepository: dataRepository)
    }
    
    func eventEditViewController(_ coder: NSCoder, event: Event) -> EventEditViewController? {
        EventEditViewController(coder: coder, dataRepository: dataRepository, event: event)
    }
    
    func memberListViewController(_ coder: NSCoder) -> MemberListViewController? {
        MemberListViewController(coder, dataRepository: dataRepository, viewControllerFactory: self)
    }
    
    func memberDetailViewController(_ coder: NSCoder, member: Member) -> MemberDetailViewController? {
        MemberDetailViewController(member: member, coder: coder, viewControllerFactory: self)
    }
    
    func memberAddViewController(_ coder: NSCoder) -> MemberAddViewController? {
        MemberAddViewController(coder: coder, dataRepository: dataRepository)
    }
    
    func memberEditViewController(_ coder: NSCoder, member: Member) -> MemberEditViewController? {
        MemberEditViewController(coder, member: member, dataRepository: dataRepository)
    }
    
    let viewFactory: ViewFactory
    let dataRepository: DataRepository
}
