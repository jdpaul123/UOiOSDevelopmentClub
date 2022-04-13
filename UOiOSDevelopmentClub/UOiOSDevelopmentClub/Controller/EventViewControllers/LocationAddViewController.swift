//
//  LocationAddViewController.swift
//  UOiOSDevelopmentClub
//
//  Created by Jonathan Paul on 4/13/22.
//

import Foundation
import UIKit

class LocationAddViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    // MARK: Properties
    private let dataRepository: DataRepository
    
    // MARK: Outlets
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var countryTextField: UITextField!
    @IBOutlet weak var stateTextField: UITextField!
    @IBOutlet weak var zipCodeTextField: UITextField!
    @IBOutlet weak var directionsNotesTextField: UITextField!
    
    // MARK: Initialization
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init?(coder: NSCoder, dataRepository: DataRepository) {
        self.dataRepository = dataRepository
        super.init(coder: coder)
    }
    
    // MARK: Actions
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        //dismiss(animated: true, completion: nil)
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        dataRepository.addLocation(with: [], address: addressTextField.text ?? "", city: cityTextField.text ?? "", country: countryTextField.text ?? "", state: stateTextField.text ?? "", zipCode: zipCodeTextField.text ?? "", directionNotes: directionsNotesTextField.text ?? "")
        //dismiss(animated: true, completion: nil)
        navigationController?.popViewController(animated: true)

    }
    
}
