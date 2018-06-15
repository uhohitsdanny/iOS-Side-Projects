//
//  UIAlert+Custom.swift
//  SpyMe
//
//  Created by Danny Navarro on 6/14/18.
//  Copyright © 2018 Danny Navarro. All rights reserved.
//

import Foundation
import UIKit

extension UIAlertController {
    
    static func PasswordValidityAlert() -> UIAlertController{
        let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
        let title : String = "Invalid Password"
        let message: String = "Please input a valid password\n"
            + "(no whitespaces or empty passwords)"
        
        // Create attributed fonts
        let titleFont:[NSAttributedStringKey : AnyObject] = [ NSAttributedStringKey.font : UIFont(name: "Raleway", size: 18)! ]
        let messageFont:[NSAttributedStringKey : AnyObject] = [ NSAttributedStringKey.font : UIFont(name: "Raleway", size: 11)! ]
        
        // Create title and message with the attributed fonts
        let attributedTitle = NSMutableAttributedString(string: title, attributes: titleFont)
        let attributedMessage = NSMutableAttributedString(string: message, attributes: messageFont)
        alert.setValue(attributedTitle, forKey: "attributedTitle")
        alert.setValue(attributedMessage, forKey: "attributedMessage")
        
        
        // Custom Alert Style
        alert.view.tintColor = .gray
        alert.view.backgroundColor = .white
        alert.view.layer.cornerRadius = 30
        
        // Alert Actions
        let okAction = UIAlertAction(title: "Okay", style: .default, handler: nil)
        
        alert.addAction(okAction)
        
        return alert
    }
    
    
}


