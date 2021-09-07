//
//  Styling.swift
//  UOiOSDevelopmentClub
//
//  Created by Jonathan Paul on 9/2/21.
//
// Based on CodeWithChris video for Firebase Authentication https://www.youtube.com/watch?v=1HN7usMROt8
// The included styling here is used for the all login related windows

import UIKit

class Utilities {
    static func styleTextField(_ textfield: UITextField) {
        
        // Create the bottom line
        let bottomLine = CALayer()
        
        bottomLine.frame = CGRect(x: 0, y: textfield.frame.height, width: textfield.frame.width, height: 2)
        
        bottomLine.backgroundColor = UIColor.init(red: 48/255, green: 173/255, blue: 99/255, alpha: 1).cgColor
        
        // Remove boarder on text field
        textfield.borderStyle = .none
        
        // Add the line to the text field
        textfield.layer.addSublayer(bottomLine)
    }
    
    static func styleFilledButton(_ button: UIButton) {
        // Filled rounded corner style
        button.backgroundColor = UIColor.green //UIColor.init(red: 48/255, green: 173/255, blue: 99/255, alpha: 1)
        button.layer.cornerRadius = 25.0
        button.tintColor = UIColor.white
    }
    
    static func styleHollowButton(_ button: UIButton) {
        // Hollow rounded corner style
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.green.cgColor
        button.layer.cornerRadius = 25.0
        button.tintColor = UIColor.black
    }
}
