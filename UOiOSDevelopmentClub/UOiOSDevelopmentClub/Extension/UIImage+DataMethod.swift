//
//  UIImage+DataMethod.swift
//  UOiOSDevelopmentClub
//
//  Created by Jonathan Paul on 8/7/21.
//

import Foundation
import UIKit

extension UIImage {
    /*
     Simple method to make an image turn to data that can be stored by Core Data
     */
    
    var toData: Data? {
        return pngData()
    }
}
