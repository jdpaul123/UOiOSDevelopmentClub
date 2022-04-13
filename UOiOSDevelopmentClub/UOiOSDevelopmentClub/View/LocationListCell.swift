//
//  LocationCell.swift
//  UOiOSDevelopmentClub
//
//  Created by Jonathan Paul on 4/13/22.
//

import UIKit

class LocationListCell: UITableViewCell {
    @IBOutlet private var locationName: UILabel?
    
    func setCellData(location: Location) {
        locationName?.text = location.address
    }
}
