//
//  MemberAddViewController.swift
//  UOiOSDevelopmentClub
//
//  Created by Jonathan Paul on 8/23/21.
//

import UIKit

class MemberAddViewController: UITableViewController {
    // MARK: Properties
    let dataRepository: DataRepository
    
    @IBOutlet weak var saveBarButton: UIBarButtonItem!
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var positionField: UITextField!
    @IBOutlet weak var phoneField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var aboutField: UITextView!
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init?(coder: NSCoder, dataRepository: DataRepository) {
        self.dataRepository = dataRepository
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        dataRepository.addMember(about: aboutField.text ?? "", position: positionField.text ?? "", email: emailField.text ?? "", phone: phoneField.text ?? "", name: nameField.text ?? "", picture: imageView.image?.toData ?? Data.init())
        dismiss(animated: true, completion: nil)
    }
    
    // Help for creating the image picker from IOS Academy YouTube channel: https://www.youtube.com/watch?v=yggOGEzueFk
    @IBOutlet var imageView: UIImageView!
    
    @IBAction func pickImageButtonPressed() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true // lets you select a cropped square of the photo
        present(imagePickerController, animated: true)
    }
}

extension MemberAddViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
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
