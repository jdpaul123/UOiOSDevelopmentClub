//
//  MemberDetailViewContoller.swift
//  UOiOSDevelopmentClub
//
//  Created by Jonathan Paul on 8/5/21.
//

import UIKit

class MemberDetailViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView?.contentMode = .scaleAspectFill
        imageView?.layer.cornerRadius = (imageView?.frame.size.width)! / 2
    }
    
    // MARK: Initializer
    init?(member: Member, coder: NSCoder, viewControllerFactory: ViewControllerFactory) {
        self.member = member
        self.viewControllerFactory = viewControllerFactory
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Properties
    private let member: Member
    private let viewControllerFactory: ViewControllerFactory

    @IBOutlet private var imageView: UIImageView?
    @IBOutlet private var nameLabel: UILabel?
    @IBOutlet private var positionLabel: UILabel?
    @IBOutlet private var aboutLabel: UILabel?
    @IBOutlet private var emailLabel: UILabel?
    @IBOutlet private var phoneLabel: UILabel?
    
    @IBOutlet weak var editMemberButton: UIBarButtonItem!
    
    func setMemberDetailData(member: Member) {
        imageView?.image = UIImage.init(data: member.picture)
        nameLabel?.text = member.name
        positionLabel?.text = member.position
        aboutLabel?.text = member.about
        emailLabel?.text = member.email
        phoneLabel?.text = member.phone
    }
    
    @IBSegueAction private func createMemberEditViewController(_ coder: NSCoder) -> MemberEditViewController? {
        return viewControllerFactory.memberEditViewController(coder, member: member)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationItem.title = member.name
        setMemberDetailData(member: member)
        
        if Injector.shared.isSignedInAsAdmin == false {
            editMemberButton.makeDisabledAndInvisable()
        }
        else {
            editMemberButton.makeEnabledAndVisable(red: 37/255, green: 150/255, blue: 190/255)
        }
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(true)
//        navigationItem.title = member.name
//        setMemberDetailData(member: member)
//    }
}
