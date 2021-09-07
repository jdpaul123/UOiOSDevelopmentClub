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
        /*
         Formatting the date for events to show the data in a easily understandable way
         */
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = .current
        dateFormatter.locale = .current
        dateFormatter.dateFormat = "EEEE, MMM d, yyyy" //"MM/dd/yyyy"
        
        return dateFormatter.string(from: date)
    }
    
    func formattedTime(date:Date) -> String {
        /*
         Formatting the time from the data stored in the event to be easity understood by users
         */
        let timeFormatter = DateFormatter()
        timeFormatter.timeZone = .current
        timeFormatter.locale = .current
        timeFormatter.dateFormat = "hh:mm a"
        
        return timeFormatter.string(from: date)
    }
    
    func formattedLocation(location: Location) -> String {
        /*
         Formattign the location to be easirt understood by users in event entities
         */
        "\(location.address), \(location.city), \(location.state) \(location.zipCode)"
    }
}
