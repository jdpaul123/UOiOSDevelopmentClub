//
//  UIButtonItem+Makeinvisable.swift
//  UOiOSDevelopmentClub
//
//  Created by Jonathan Paul on 9/3/21.
//

import UIKit

extension UIBarButtonItem {
    func makeDisabledAndInvisable() {
        self.isEnabled = false
        self.tintColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0)
    }
    
    func makeEnabledAndVisable(red: CGFloat, green: CGFloat, blue: CGFloat) {
        self.isEnabled = true
        self.tintColor = UIColor(red: red, green: green, blue: blue, alpha: 1)
        
    }
}
