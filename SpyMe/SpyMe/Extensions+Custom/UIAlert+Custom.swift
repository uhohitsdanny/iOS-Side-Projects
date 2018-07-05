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
    
    static func PasswordValidityAlert() -> UIAlertController
    {
        let title : String = "Invalid Password"
        let message: String = "Please input a valid password"

        return generateCustomAlert(title, message)
    }
    
    static func RoomExistenceAlert() -> UIAlertController
    {
        let title : String = "Room ID already exists"
        let message: String = "Please try a different room ID"
        
        return generateCustomAlert(title, message)
    }
    
    fileprivate static func generateCustomAlert(_ title:String,_ message:String) -> UIAlertController
    {
        let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
        
        // Create attributed fonts
        let titleFont:[NSAttributedStringKey : AnyObject] = [ NSAttributedStringKey.font : UIFont(name: "Raleway", size: 18)! ]
        let messageFont:[NSAttributedStringKey : AnyObject] = [ NSAttributedStringKey.font : UIFont(name: "Raleway", size: 11)!]
        
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


