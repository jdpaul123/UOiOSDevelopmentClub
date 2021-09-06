//
//  FormUtilities.swift
//  UOiOSDevelopmentClub
//
//  Created by Jonathan Paul on 9/2/21.
//
// Based on CodeWithChris video for Firebase Authentication https://www.youtube.com/watch?v=1HN7usMROt8
// The passwordTest stores a predicate regular expression to make sure that the passowrd created for accounts conforms to:
// - at least 8 characters
// - contains a special character
// - contains a number

import UIKit

class FormUitilies {
    static func isPasswordValid(_ password: String) -> Bool {
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }
}
