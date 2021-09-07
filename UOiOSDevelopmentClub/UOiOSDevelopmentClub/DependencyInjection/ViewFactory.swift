//
//  ViewFactory.swift
//  UOiOSDevelopmentClub
//
//  Created by Jonathan Paul on 8/2/21.
//

import Foundation

class ViewFactory {
    /*
     Used to instantiate SwiftUI views that are needed to be embeded in UIKit view controllers
     */
    func createWelcomeView() -> Welcome {
        Welcome()
    }
}
