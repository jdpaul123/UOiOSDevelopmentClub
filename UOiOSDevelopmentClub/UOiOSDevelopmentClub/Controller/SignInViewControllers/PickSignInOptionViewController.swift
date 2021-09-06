//
//  PickSignInOptionViewController.swift
//  UOiOSDevelopmentClub
//
//  Created by Jonathan Paul on 9/2/21.
//
// Based on CodeWithChris video for Firebase Authentication https://www.youtube.com/watch?v=1HN7usMROt8

import UIKit

class PickSignInOptionViewController: UIViewController {
    
    let viewControllerFactory: ViewControllerFactory
    
    @IBOutlet weak var adminLogInButton: UIButton!
    @IBOutlet weak var requestAdminAccountButton: UIButton!
    
    required init?(coder: NSCoder) {
        fatalError("Not implimented")
    }
    
    init?(viewControllerFactory: ViewControllerFactory, coder: NSCoder) {
        self.viewControllerFactory = viewControllerFactory
        super.init(coder: coder)
    }
    
    @IBAction func adminLogInButtonTapped(_ sender: Any) {

    }
    
    @IBAction func requestAdminAccountButtonTapped(_ sender: Any) {
    }
    
    @IBSegueAction private func createLoginView(_ coder: NSCoder) -> LogInViewController? {
        viewControllerFactory.logInViewController(coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpElements()
    }
    
    func setUpElements() {
        Utilities.styleFilledButton(adminLogInButton)
        Utilities.styleHollowButton(requestAdminAccountButton)
    }
}
