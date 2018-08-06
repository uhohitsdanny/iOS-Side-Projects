//
//  ConnectionRoom_VC.swift
//  SpyMe
//
//  Created by Danny Navarro on 6/1/18.
//  Copyright © 2018 Danny Navarro. All rights reserved.
//

import UIKit

class ConnRoom_VC: UIViewController {

    @IBOutlet weak var roomIdTextField: UITextField?
    @IBOutlet weak var pwTextField: UITextField?
    
    var room: Room? = nil
    var player: Civilian? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        log("**** ConnRoom ViewController loaded ****")
        //roomIdTextField?.delegate = self
        setupKeyboard()
    }

    func setupKeyboard(){
        roomIdTextField?.delegate = self
        pwTextField?.delegate = self
        
        roomIdTextField?.returnKeyType = .done
        pwTextField?.returnKeyType = .done
    }
}

// MARK: - Button Functions2

extension ConnRoom_VC {
    @IBAction func dismissViewController()
    {
        self.dismiss(animated: true) {
            log("**** ConnRoom ViewController dismissed ****")
        }
    }
}

// MARK: - Segue Actions

extension ConnRoom_VC {
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "joinGameQueue" {
            
            if checkText(text: (roomIdTextField?.text)!) && checkText(text: (pwTextField?.text)!)
            {
                Room(id: (roomIdTextField?.text)!, pw: (pwTextField?.text)!).joinRoom(player: (player?.name)!)
                { (validpassword,success, room) in
                    if success
                    {
                        if let joinedRoom = room
                        {
                            log("Joining Room: \(joinedRoom.id)")
                            self.room = joinedRoom
                            self.player!.roomid = joinedRoom.id
                            self.player!.status = .joinsuccess
                            self.performSegue(withIdentifier: "joinGameQueue", sender: self)
                        }
                    }
                    else
                    {
                        if !validpassword!
                        {
                            log("Failed to join room: " + (room?.id)!)
                            log("Reason: incorrect password")
                            
                            let validityAlert = UIAlertController.WrongPasswordAlert()
                            self.present(validityAlert, animated: false, completion: nil)
                        }
                        else
                        {
                            log("Failed to join room: " + (room?.id)!)
                            log("Reason: Room was not found")
                            
                            let validityAlert = UIAlertController.RoomNotFoundAlert()
                            self.present(validityAlert, animated: false, completion: nil)
                        }
                    }
                }
            }
            else
            {
                let validityAlert = UIAlertController.PasswordValidityAlert()
                self.present(validityAlert, animated: false, completion: nil)
                return false
            }
            
        }
        if self.player!.status == .joinsuccess
        {
            return true
        }
        return false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "joinGameQueue"
        {
            if let destinationVC = segue.destination as? GameQueue_VC
            {
                destinationVC.room = self.room
            }
        }
    }
}
