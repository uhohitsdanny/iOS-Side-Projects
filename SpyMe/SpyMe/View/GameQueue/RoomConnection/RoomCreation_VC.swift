//
//  RoomCreation_VC.swift
//  SpyMe
//
//  Created by Danny Navarro on 5/7/18.
//  Copyright © 2018 Danny Navarro. All rights reserved.
//

import UIKit

class RoomCreation_VC: UIViewController {

    @IBOutlet weak var roomIdTextField: UITextField?
    @IBOutlet weak var pwTextField: UITextField?
    
    var player: Civilian?
    var seconds: Int = DEFAULT_TIME
    
    override func viewDidLoad() {
        super.viewDidLoad()
        log("RoomCreation View Controller loaded")
        setupKeyboard()
    }
    
    func setupKeyboard(){
        roomIdTextField?.delegate = self
        pwTextField?.delegate = self
        
        roomIdTextField?.returnKeyType = .done
        pwTextField?.returnKeyType = .done
    }
}

// MARK: - Helper Functions

extension RoomCreation_VC {
    func checkText(text:String) -> Bool {
        let whitespace = NSCharacterSet.whitespaces
        
        let range = text.rangeOfCharacter(from: whitespace)
        
        // range will be nil if no whitespace is found
        if range != nil || text.isEmpty {
            return false
        } else {
            return true
        }
    }
    
    @IBAction func registerTimer(_ sender: UIButton) {
        if let minute = Int(sender.currentTitle!) {
            self.seconds = minute * 60
        } else {
            self.seconds = DEFAULT_TIME
        }
    }
}

// MARK: - Segue Actions

extension RoomCreation_VC {
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "createGameQueue" {
            
            // Check if password field is empty or contains whitespaces
            // If not alert the user to enter a valid password
            if checkText(text: (roomIdTextField?.text)!) && checkText(text: (pwTextField?.text)!) {
                
                let room = Room(id: (roomIdTextField?.text)!)
                room.pw = (pwTextField?.text)!
                
                player?.roomid = room.id
                
                room.createRoom(room: room) { (success) in
                    if success {
                        log("Successfully created room: " + (room.id))
                    } else {
                        log("Failed to create room: " + (room.id))

                    }
                }
                
                if self.player!.status == .joinsuccess {
                    return true
                }
                return false
            }else{
                let validityAlert = UIAlertController.PasswordValidityAlert()
                self.present(validityAlert, animated: false, completion: nil)
                return false
            }
        }
        return false
    }
}
