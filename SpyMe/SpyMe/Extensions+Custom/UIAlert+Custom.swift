//
//  UIAlert+Custom.swift
//  SpyMe
//
//  Created by Danny Navarro on 6/14/18.
//  Copyright © 2018 Danny Navarro. All rights reserved.
//

import Foundation
import UIKit

enum AlertType {
    case notification
    case confirmation
}

extension UIAlertController {
    
    // Alert for invalid password format
    static func PasswordValidityAlert() -> UIAlertController
    {
        let title : String = "Invalid Password"
        let message: String = "Please input a valid password"

        return generateCustomAlert(title, message, .notification, from: nil)
    }
    
    // Alert for wrong password
    static func WrongPasswordAlert() -> UIAlertController
    {
        let title : String = "Wrong Password"
        let message: String = "The password inputted is incorrect"
        
        return generateCustomAlert(title, message, .notification, from: nil)
    }
    
    // Alert for existence of a room
    static func RoomExistenceAlert() -> UIAlertController
    {
        let title : String = "Room ID already exists"
        let message: String = "Please try a different room ID"
        
        return generateCustomAlert(title, message, .notification, from: nil)
    }
    
    // Alert if room was not joined successfully
    static func RoomNotFoundAlert() -> UIAlertController
    {
        let title : String = "Room not found"
        let message: String = "The room either does not exist or there was an error in the system\n"
                            + "Please try again or check the room id again"
        
        return generateCustomAlert(title, message, .notification, from: nil)
    }
    
    // Room in game alert
    static func RoomBusy() -> UIAlertController
    {
        let title : String = "Room is busy"
        let message: String = "The room is currently ingame."
        
        return generateCustomAlert(title, message, .notification, from: nil)
    }
    
    // Assurance if the user is sure that the user is ready to end the game and vote
    static func VotingAssurance(_ vc:UIViewController) -> UIAlertController
    {
        let title : String = "Are you sure you want to vote now?"
        let message: String = "Once the game room is left, it cannot be rejoined."
        
        return generateCustomAlert(title, message, .confirmation, from: vc)
    }
    
    fileprivate static func generateCustomAlert(_ title:String,_ message:String,_ type:AlertType, from viewController:UIViewController?) -> UIAlertController
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
        if type == .notification
        {
            let okAction = UIAlertAction(title: "Okay", style: .default, handler: nil)
            alert.addAction(okAction)
        }
        else if type == .confirmation
        {
            let voteAction = UIAlertAction(title: "Vote", style: .default) { (action) in
                if viewController != nil
                {
                    let gameroomVC = viewController as! GameRoom_VC
                    gameroomVC.goToVotingVC(true)
                }
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
            
            alert.addAction(voteAction)
            alert.addAction(cancelAction)
        }

        return alert
    }
}


