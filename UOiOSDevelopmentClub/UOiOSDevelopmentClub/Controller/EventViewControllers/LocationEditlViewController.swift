//
//  LocationDetailViewController.swift
//  UOiOSDevelopmentClub
//
//  Created by Jonathan Paul on 4/13/22.
//

import Foundation


import UIKit
import CoreData

class LocationEditViewController: UIViewController, NSFetchedResultsControllerDelegate, UITextFieldDelegate, UITextViewDelegate {
    
    // MARK: Properties
    private let dataRepository: DataRepository
    private let location: Location
    
    // MARK: Outlets
    
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var countryTextField: UITextField!
    @IBOutlet weak var stateTextField: UITextField!
    @IBOutlet weak var zipCodeTextField: UITextField!
    @IBOutlet weak var directionsNotesTextField: UITextField!
    
    // MARK: Initialization
    init?(coder: NSCoder, dataRepository: DataRepository, location: Location) {
        self.dataRepository = dataRepository
        self.location = location
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Actions
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        location.address = addressTextField.text ?? ""
        location.city = cityTextField.text ?? ""
        location.country = countryTextField.text ?? ""
        location.state = stateTextField.text ?? ""
        location.zipCode = zipCodeTextField.text ?? ""
        location.directionsNotes = directionsNotesTextField.text ?? ""
        dataRepository.eventOrMemberEdited() // This just calls saveViewContext so it will work for location too. Kinda jank
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func deleteLocationPressed(_ sender: Any) {
        let alert = UIAlertController(title: "Delete Location", message: "Are you sure you want to delete this location. NOTE: It will effect any events with this location", preferredStyle: .actionSheet)
        
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: { (action) in
            self.location.isTrashed = true
            self.dataRepository.eventOrMemberEdited()
            self.popTo(LocationListViewController.self)
        })
        alert.addAction(deleteAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        /*
         Fill in the currently saved data
         */
        addressTextField.text = location.address
        cityTextField.text = location.city
        countryTextField.text = location.country
        stateTextField.text = location.state
        zipCodeTextField.text = location.zipCode
        directionsNotesTextField.text = location.directionsNotes
    }
}
