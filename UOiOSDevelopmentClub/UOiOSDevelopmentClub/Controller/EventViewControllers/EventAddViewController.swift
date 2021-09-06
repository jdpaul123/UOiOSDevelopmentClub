//
//  EventAddViewController.swift
//  UOiOSDevelopmentClub
//
//  Created by Jonathan Paul on 8/26/21.
//

import UIKit
import CoreData

class EventAddViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    // MARK: Properties
    var locationResultsController: NSFetchedResultsController<Location>? = nil
    let dataRepository: DataRepository
    var selectedLocation = Location.init()
    
    @IBOutlet weak var saveBarButton: UIBarButtonItem!
    
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var locationPicker: UIPickerView!
    @IBOutlet weak var informationView: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    
    // MARK: Initialization
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init?(coder: NSCoder, dataRepository: DataRepository) {
        self.dataRepository = dataRepository
        super.init(coder: coder)
        
        locationResultsController = dataRepository.locationResultsController(delegate: self)
        // select the first location that will show in the picker as the default location
        selectedLocation = locationResultsController?.fetchedObjects?[0] ?? Location.init()
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        dataRepository.addEvent(to: selectedLocation, title: titleField.text ?? "", about: informationView.text, date: datePicker.date, picture: imageView.image?.toData ?? Data.init() )
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func pickImageButtonPressed() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true // lets you select a cropped square of the photo
        present(imagePickerController, animated: true)
    }
}

extension EventAddViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {
            imageView.image = image
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}


extension EventAddViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    // Link for learning to set up the Location Picker: https://codewithchris.com/uipickerview-example/#step2
    // number of columns in picker
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return locationResultsController?.fetchedObjects?.count ?? 0
    }
    
    // the data to return for the row and component (column) that's being passed
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return locationResultsController?.fetchedObjects?[row].address ?? ""
    }
    
    // Capture the picker view selected location
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // This method is triggered whenever the user makes a change to the picker selection
        // The parameter named row and component represents what was selected.
        selectedLocation = locationResultsController?.fetchedObjects?[row] ?? Location.init() // SHOULD NOT RETURN Location.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationPicker.delegate = self
        locationPicker.dataSource = self
    }
}
