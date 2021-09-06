//
//  EventEditViewController.swift
//  UOiOSDevelopmentClub
//
//  Created by Jonathan Paul on 8/26/21.
//

import UIKit
import CoreData

class EventEditViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    // MARK: Properties
    var locationResultsController: NSFetchedResultsController<Location>? = nil
    let dataRepository: DataRepository
    var selectedLocation = Location.init()
    let event: Event
    
    @IBOutlet weak var saveBarButton: UIBarButtonItem!
    
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var locationPicker: UIPickerView!
    @IBOutlet weak var informationView: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    
    // MARK: Initialization
    init?(coder: NSCoder, dataRepository: DataRepository, event: Event) {
        self.dataRepository = dataRepository
        self.event = event
        super.init(coder: coder)
        
        locationResultsController = dataRepository.locationResultsController(delegate: self)
        // select the first location that will show in the picker as the default location
        selectedLocation = event.location
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        event.location = selectedLocation
        event.title = titleField.text ?? ""
        event.about = informationView.text
        event.date = datePicker.date
        event.picture = imageView.image?.toData ?? Data.init()
        dataRepository.eventOrMemberEdited()
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func pickImageButtonPressed() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true // lets you select a cropped square of the photo
        present(imagePickerController, animated: true)
    }
    
    @IBAction func deleteButtonPressed() {
        let alert = UIAlertController(title: "Delete Event", message: "Are you sure you want to delete this Event", preferredStyle: .actionSheet)
        
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: { (action) in
            self.event.isTrashed = true
            self.dataRepository.eventOrMemberEdited()
            self.popTo(EventsListViewController.self)
        })
        alert.addAction(deleteAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)
    }
}

extension EventEditViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
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


extension EventEditViewController: UIPickerViewDelegate, UIPickerViewDataSource {
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
        
        titleField.text = event.title
        datePicker.date = event.date
        
        // TODO set location picker to the correct location
        
        informationView.text = event.about
        imageView.image = UIImage.init(data: event.picture ?? Data.init())
    }
}
