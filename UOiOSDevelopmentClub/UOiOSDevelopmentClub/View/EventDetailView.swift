//
//  EventDetailView.swift
//  UOiOSDevelopmentClub
//
//  Created by Jonathan Paul on 8/7/21.
//

import UIKit

class EventDetailView: UIView {
    @IBOutlet private var imageView: UIImageView?
    @IBOutlet private var titleLabel: UILabel?
    @IBOutlet private var dateLabel: UILabel?
    @IBOutlet private var timeLabel: UILabel?
    @IBOutlet private var locationLabel: UILabel?
    @IBOutlet private var aboutLabel: UILabel?
        
    func setEventDetailData(event: Event) {
        titleLabel?.text = event.title
        
        let formattedDate = formattedDate(date: event.date)
        let formattedTime = formattedTime(date: event.date)
        dateLabel?.text = formattedDate
        timeLabel?.text = formattedTime
        
        let formattedLocation = formattedLocation(location: event.location)
        locationLabel?.text = formattedLocation
        
        aboutLabel?.text = event.about
        
        imageView?.image = UIImage.init(data: event.picture!)
    }
}
