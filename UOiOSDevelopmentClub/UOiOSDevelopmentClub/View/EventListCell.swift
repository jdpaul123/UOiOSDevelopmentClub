//
//  EventListCell.swift
//  UOiOSDevelopmentClub
//
//  Created by Jonathan Paul on 8/5/21.
//

import UIKit

class EventListCell: UITableViewCell {
    @IBOutlet private var title: UILabel?
    @IBOutlet private var date: UILabel?
    @IBOutlet private var time: UILabel?
    
    func setCellData(event: Event) {
        title?.text = event.title

        let formattedDate = formattedDate(date: event.date)
        let formattedTime = formattedTime(date: event.date)
        
        date?.text = formattedDate
        time?.text = formattedTime
    }
}
