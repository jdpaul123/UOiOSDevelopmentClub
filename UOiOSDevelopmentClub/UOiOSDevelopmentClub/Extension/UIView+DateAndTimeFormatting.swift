//
//  UIViewController+DateAndTimeFormatting.swift
//  UOiOSDevelopmentClub
//
//  Created by Jonathan Paul on 8/7/21.
//

import Foundation
import UIKit

extension UIView {
    func formattedDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = .current
        dateFormatter.locale = .current
        dateFormatter.dateFormat = "EEEE, MMM d, yyyy" //"MM/dd/yyyy"
        
        return dateFormatter.string(from: date)
    }
    
    func formattedTime(date:Date) -> String {
        let timeFormatter = DateFormatter()
        timeFormatter.timeZone = .current
        timeFormatter.locale = .current
        timeFormatter.dateFormat = "hh:mm a"
        
        return timeFormatter.string(from: date)
    }
    
    func formattedLocation(location: Location) -> String {
        "\(location.address), \(location.city), \(location.state) \(location.zipCode)"
    }
}
