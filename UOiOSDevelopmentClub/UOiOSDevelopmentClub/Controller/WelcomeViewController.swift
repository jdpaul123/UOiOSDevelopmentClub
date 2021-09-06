//
//  WelcomeViewController.swift
//  UOiOSDevelopmentClub
//
//  Created by Jonathan Paul on 8/2/21.
//

import UIKit
import SwiftUI
import FirebaseAuth

class WelcomeViewController: UIViewController {
    
    @IBOutlet weak var adminSignInButton: UIBarButtonItem!
    
    // MARK: Properties
    var savedBarButtonState = UIBarButtonItem()
    
    private let viewFactory: ViewFactory
    private let viewControllerFactory: ViewControllerFactory
    
    required init?(coder: NSCoder) {
        fatalError("Not implimented")
    }
    
    init?(viewFactory: ViewFactory, viewControllerFactory: ViewControllerFactory, coder: NSCoder) {
        self.viewFactory = viewFactory
        self.viewControllerFactory = viewControllerFactory
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        let welcomeScreen = UIHostingController(rootView: viewFactory.createWelcomeView())

        super.viewDidLoad()
        
        // SwiftUI Interop
        addChild(welcomeScreen)
        view.addSubview(welcomeScreen.view)
        
        setupConstraints(welcomeScreen: welcomeScreen)
        
    }
    
    @IBSegueAction private func createPickSignInOptionViewController(_ coder: NSCoder) -> PickSignInOptionViewController? {
        viewControllerFactory.pickSignInOptionViewController(coder)
    }
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if Auth.auth().currentUser != nil {
            // TODO If you are signed in and you open this view then the saved leftBarButton is the sign out button. THis is bad. We want the saved button to be
            // the sign in button MUST FIX THIS
            //savedBarButtonState = navigationItem.leftBarButtonItem!
            
            navigationItem.leftBarButtonItem?.title = "Sign Out"
            //    = UIBarButtonItem(title: "Sign Out", style: .done, target: self, action: #selector(handleSignOutButtonTapped))
        } else {
            navigationItem.leftBarButtonItem?.title = "Admin Log In"
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "toLoginSeque" && Auth.auth().currentUser != nil {
            handleSignOutButtonTapped()
            return false
        }
        return true
    }
    
    @objc func handleSignOutButtonTapped() {
        let alert = UIAlertController(title: "Sign Out", message: "Are you sure you want to sign out?", preferredStyle: .actionSheet)
        
        let signOutAction = UIAlertAction(title: "Sign Out", style: .destructive) { (action) in
            do {
                try Auth.auth().signOut()
                self.navigationItem.leftBarButtonItem?.title = "Admin Log In"
                Injector.shared.isSignedInAsAdmin = false
                // set the button back to being a log in button
//                self.navigationItem.leftBarButtonItem = self.savedBarButtonState
            } catch let err {
                print(err)
            }
        }
        alert.addAction(signOutAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func setupConstraints(welcomeScreen: UIViewController) {
        welcomeScreen.view.translatesAutoresizingMaskIntoConstraints = false
        welcomeScreen.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        welcomeScreen.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        welcomeScreen.view.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        welcomeScreen.view.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
}
