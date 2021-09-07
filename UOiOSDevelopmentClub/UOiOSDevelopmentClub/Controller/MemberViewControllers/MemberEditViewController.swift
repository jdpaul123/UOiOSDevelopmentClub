//
//  MemberEditViewController.swift
//  UOiOSDevelopmentClub
//
//  Created by Jonathan Paul on 8/23/21.
//

import UIKit

class MemberEditViewController: UITableViewController, UITextFieldDelegate, UITextViewDelegate  {
    // MARK: Initializer
    init?(_ coder: NSCoder, member: Member, dataRepository: DataRepository) {
        self.member = member
        self.dataRepository = dataRepository
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Properties
    private let member: Member
    private let dataRepository: DataRepository
    
    @IBOutlet weak var saveBarButton: UIBarButtonItem!
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var positionField: UITextField!
    @IBOutlet weak var phoneField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var aboutField: UITextView!
    @IBOutlet weak var imagePickerButton: UIButton!
    @IBOutlet weak var imagePickerView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameField.text = member.name
        positionField.text = member.position
        phoneField.text = member.phone
        emailField.text = member.email
        aboutField.text = member.about
        imagePickerView.image = UIImage.init(data: member.picture)
        
        nameField.delegate = self
        positionField.delegate = self
        phoneField.delegate = self
        emailField.delegate = self
        
        // Next 4 lines are for dismissing the keyboard
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard(_:)))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameField.resignFirstResponder()
        positionField.resignFirstResponder()
        phoneField.resignFirstResponder()
        emailField.resignFirstResponder()
        return true
    }
    
    // Called when a click is processed outside the keyboard or a field to dismiss the keyboard
    @objc
    func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        nameField.resignFirstResponder()
        positionField.resignFirstResponder()
        phoneField.resignFirstResponder()
        emailField.resignFirstResponder()
        aboutField.resignFirstResponder()
    }
    
    @IBAction func pickImageButtonPressed() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true // lets you select a cropped square of the photo
        present(imagePickerController, animated: true)
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveButtonPressed() {
        member.name = nameField.text ?? ""
        member.position = positionField.text ?? ""
        member.phone = phoneField.text ?? ""
        member.email = emailField.text ?? ""
        member.about = aboutField.text ?? ""
        member.picture = imagePickerView.image?.toData ?? Data.init()
        
        dataRepository.eventOrMemberEdited()
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func deleteButtonPressed() {
        let alert = UIAlertController(title: "Delete Member/Advisor", message: "Are you sure you want to delete this member/advisor", preferredStyle: .actionSheet)
        
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: { (action) in
            //self.dataRepository.delete(self.member) // not deleting directly because delete won't propagate for people who already have the data downloaded to Core Data
            self.member.isTrashed = true
            self.dataRepository.eventOrMemberEdited()
            self.popTo(MemberListViewController.self)
        })
        alert.addAction(deleteAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)
    }
}

extension MemberEditViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {
            imagePickerView.image = image
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
