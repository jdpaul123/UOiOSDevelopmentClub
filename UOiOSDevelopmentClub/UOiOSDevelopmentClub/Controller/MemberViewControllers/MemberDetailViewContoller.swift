//
//  MemberDetailViewContoller.swift
//  UOiOSDevelopmentClub
//
//  Created by Jonathan Paul on 8/5/21.
//

import UIKit
import MessageUI

class MemberDetailViewController: UIViewController, MFMailComposeViewControllerDelegate {
    
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

    // MARK: IBOutlets
    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var positionLabel: UILabel!
    @IBOutlet weak var emailButton: UIButton!
    @IBOutlet private var aboutTextView: UITextView!

    
    @IBOutlet weak var editMemberButton: UIBarButtonItem!
    
    func setMemberDetailData(member: Member) {
        imageView.image = UIImage.init(data: member.picture)
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = (imageView?.frame.size.width)! / 2
        imageView.layer.borderWidth = 2.0
        imageView.layer.borderColor = CGColor(red: 0, green: 1, blue: 0, alpha: 1)
        nameLabel.text = member.name
        positionLabel.text = member.position
        aboutTextView.text = member.about
        emailButton.setTitle(member.email, for: .normal)
    }
    
    
    // When the email is clicked
    @IBAction func sendEmail(_ sender: UIButton) {
        // https://stackoverflow.com/questions/25981422/how-to-open-mail-app-from-swift
        let recipientEmail = member.email
        let subject = "Hi \(member.name)"
        let body = "Hi \(member.name),"
        
        // Show default mail composer
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients([recipientEmail])
            mail.setSubject(subject)
            mail.setMessageBody(body, isHTML: false)
            
            present(mail, animated: true)
        
        // Show third party email composer if default Mail app is not present
        } else if let emailUrl = createEmailUrl(to: recipientEmail, subject: subject, body: body) {
            UIApplication.shared.open(emailUrl)
        }
    }
    
    private func createEmailUrl(to: String, subject: String, body: String) -> URL? {
        let subjectEncoded = subject.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let bodyEncoded = body.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        let gmailUrl = URL(string: "googlegmail://co?to=\(to)&subject=\(subjectEncoded)&body=\(bodyEncoded)")
        let outlookUrl = URL(string: "ms-outlook://compose?to=\(to)&subject=\(subjectEncoded)")
        let yahooMail = URL(string: "ymail://mail/compose?to=\(to)&subject=\(subjectEncoded)&body=\(bodyEncoded)")
        let sparkUrl = URL(string: "readdle-spark://compose?recipient=\(to)&subject=\(subjectEncoded)&body=\(bodyEncoded)")
        let defaultUrl = URL(string: "mailto:\(to)?subject=\(subjectEncoded)&body=\(bodyEncoded)")
        
        if let gmailUrl = gmailUrl, UIApplication.shared.canOpenURL(gmailUrl) {
            return gmailUrl
        } else if let outlookUrl = outlookUrl, UIApplication.shared.canOpenURL(outlookUrl) {
            return outlookUrl
        } else if let yahooMail = yahooMail, UIApplication.shared.canOpenURL(yahooMail) {
            return yahooMail
        } else if let sparkUrl = sparkUrl, UIApplication.shared.canOpenURL(sparkUrl) {
            return sparkUrl
        }
        
        return defaultUrl
    }
    
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
    
    // MARK: IBSequeAction
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
}
