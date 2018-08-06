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
    
    // Button Arrays
    @IBOutlet weak var fourMinBtn: UIButton?
    @IBOutlet weak var sevenMinBtn: UIButton?
    @IBOutlet weak var tenMinBtn: UIButton?
    @IBOutlet weak var thirteenMinBtn: UIButton?
    
    var timeButtons:[UIButton] = [UIButton]()
    
    var room: Room? = nil
    var player: Civilian?
    var seconds: Int = DEFAULT_TIME
    
    override func viewDidLoad() {
        super.viewDidLoad()
        log("**** RoomCreation ViewController loaded ****")
        setupVars()
        setupKeyboard()
    }
    
    func setupVars()
    {
        timeButtons = [fourMinBtn!, sevenMinBtn!, tenMinBtn!, thirteenMinBtn!]
    }
    
    func setupKeyboard()
    {
        roomIdTextField?.delegate = self
        pwTextField?.delegate = self
        
        roomIdTextField?.returnKeyType = .done
        pwTextField?.returnKeyType = .done
    }
}

// MARK: - Button Functions
extension RoomCreation_VC {
    @IBAction func registerTimer(_ sender: UIButton) {
        if let minute = Int(sender.currentTitle!) {
            self.seconds = minute * 60
        } else {
            self.seconds = DEFAULT_TIME
        }
        
        resetBtnStates(number: sender.currentTitle!)
    }
    
    func resetBtnStates(number: String)
    {
        for btn in timeButtons
        {
            if number == btn.currentTitle
            {
                btn.layer.borderWidth = 1
                btn.layer.borderColor = UIColor.darkGray.cgColor
            }
            else
            {
                btn.layer.borderWidth = 0
            }
        }
    }
    
    @IBAction func dismissViewController()
    {
        self.dismiss(animated: true) {
            log("**** RoomCreation ViewController dismissed ****")
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
                
                let newroom = Room(id: (roomIdTextField?.text)!, pw: (pwTextField?.text)!)
                newroom.host = (player?.name)!
                newroom.seconds = self.seconds
                newroom.players.append((player?.name)!)
                player?.roomid = newroom.id
                
                newroom.createRoom(room: newroom) { (success, exists) in
                    if exists
                    {
                        // If room id already exists, alert user to enter a different ID
                        let existenceAlert = UIAlertController.RoomExistenceAlert()
                        self.present(existenceAlert, animated: false, completion: nil)
                    }
                    else
                    {
                        // else continue
                        if success
                        {
                            log("Successfully created room: " + (newroom.id))
                            log("Joining Room: \(newroom.id)")
                            
                            self.room = newroom
                            self.player!.status = .joinsuccess
                            self.performSegue(withIdentifier: "createGameQueue", sender: self)
                        }
                        else
                        {
                            log("Failed to create room: " + (newroom.id))
                        }
                    }
                }
                
                if self.player!.status == .joinsuccess
                {
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "createGameQueue"
        {
            if let destinationVC = segue.destination as? GameQueue_VC
            {
                destinationVC.room = self.room
            }
        }
    }
}
