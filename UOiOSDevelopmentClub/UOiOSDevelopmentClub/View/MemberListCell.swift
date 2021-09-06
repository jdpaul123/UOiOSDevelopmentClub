//
//  MemberListCell.swift
//  UOiOSDevelopmentClub
//
//  Created by Jonathan Paul on 8/8/21.
//

import UIKit

class MemberListCell: UITableViewCell {
    @IBOutlet private var nameLabel: UILabel?
    @IBOutlet private var positionLabel: UILabel?
    @IBOutlet private var profileImageView: UIImageView?
    
    func setCellData(member: Member) {
        nameLabel?.text = member.name
        positionLabel?.text = member.position
        let data = Data(member.picture)
        profileImageView?.image = UIImage.init(data: data)
        profileImageView?.contentMode = .scaleAspectFill
        profileImageView?.layer.cornerRadius = (profileImageView?.frame.size.width)! / 2
    }
}
