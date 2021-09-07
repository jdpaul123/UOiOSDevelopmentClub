//
//  LogInViewController.swift
//  UOiOSDevelopmentClub
//
//  Created by Jonathan Paul on 9/2/21.
//
// Based on CodeWithChris video for Firebase Authentication https://www.youtube.com/watch?v=1HN7usMROt8

import UIKit
import FirebaseAuth
import CoreData

class LogInViewController: UIViewController, NSFetchedResultsControllerDelegate {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var showHideButton: UIButton!
    
    var passwordVisible = false
    
    let dataRepository: DataRepository
    
    init?(dataRepository: DataRepository, coder: NSCoder) {
        self.dataRepository = dataRepository
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @IBAction func logInButtonTapped(_ sender: Any) {
        
        // Validate Text Fields
        let error = validateTextFields()
        
        if error != nil {
            showError(error!)
        }
        else {
            // Create cleaned version of the text fields
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            
            // Signing in the user
            Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
                if error != nil {
                    // Couldn't sign in
                    self.errorLabel.text = "\(self.errorLabel.text ?? "")\n\(error!.localizedDescription)"
                    self.errorLabel.alpha = 1
                }
                else {
                    // Signed in successfully

                    let adminResultsController = self.dataRepository.adminResultsController(delegate: self)
                    
                    // Base case is that they are not an admin
                    Injector.shared.isSignedInAsAdmin = false
                    
                    // Check that there are admins in the fetched objects
                    guard let adminObjects = adminResultsController?.fetchedObjects else {
                        self.transitionBackToWelcome()
                        return
                    }
                    
                    // Cycle through the admins and determine if this account is one
                    for admin in adminObjects {
                        if admin.email == email {
                            Injector.shared.isSignedInAsAdmin = true
                        }
                    }
                    self.transitionBackToWelcome()
                }
            }
        }
    }
    
    
    @IBAction func showHide(_ sender: Any) {
        if passwordVisible {
            passwordTextField.isSecureTextEntry = true
            showHideButton.setTitle("Show", for: .normal)
            passwordVisible = false
        } else {
            passwordTextField.isSecureTextEntry = false
            showHideButton.setTitle("Hide", for: .normal)
            passwordVisible = true
        }
    }
    
    func transitionBackToWelcome() {
        popTo(WelcomeViewController.self)
    }
    
    func showError(_ message: String) {
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    func validateTextFields() -> String? {
        if emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "please fill in both email and password fields"
        }
        
        // Check if the password is secure
        let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let isPasswordValid = FormUitilies.isPasswordValid(cleanedPassword)
        if isPasswordValid == false {
            return "Please make sure the password is at least 8 characters, contains a special character and a number."
        }
        
        return nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
    }
    
    func setUpElements() {
        errorLabel.alpha = 0
        
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
        
        Utilities.styleFilledButton(logInButton)
    }
}
