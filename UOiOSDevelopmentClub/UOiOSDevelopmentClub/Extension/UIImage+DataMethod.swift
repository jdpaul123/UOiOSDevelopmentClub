//
//  UIImage+DataMethod.swift
//  UOiOSDevelopmentClub
//
//  Created by Jonathan Paul on 8/7/21.
//

import Foundation
import UIKit

extension UIImage {
    var toData: Data? {
        return pngData()
    }
}
