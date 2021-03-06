//
//  UITableViewController+PopingMultipleViews.swift
//  UOiOSDevelopmentClub
//
//  Created by Jonathan Paul on 8/25/21.
//

import UIKit

extension UIViewController {
    /*
     https://www.darrengillman.com/index.php/2019/10/22/pop-multiple-view-controllers-from-the-navigation-stack/
     THis is used to go back to a view controller in the stack when an action is performed such as deleting an entity
     */
    func popTo<T>(_ vc: T.Type) {
        let targetVC = navigationController?.viewControllers.first{$0 is T}
        if let targetVC = targetVC {
            navigationController?.popToViewController(targetVC, animated: true)
        }
    }
}
