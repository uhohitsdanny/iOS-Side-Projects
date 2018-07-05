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
    
    var player: Civilian? = nil
    var room: Room? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        log("**** ConnRoom ViewController loaded ****")
        //roomIdTextField?.delegate = self
        setupKeyboardType()
    }

    func setupKeyboardType(){
        roomIdTextField?.delegate = self
        pwTextField?.delegate = self
        
        roomIdTextField?.returnKeyType = .done
        pwTextField?.returnKeyType = .done
    }
}

// MARK: - Button Functions

extension ConnRoom_VC {
    @IBAction func joinRoom(){
        // Query DB for the room
        room?.id = (roomIdTextField?.text)!
        room?.pw = (pwTextField?.text)!
    }
    
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
            let roomId = roomIdTextField?.text
            let pw = pwTextField?.text
            if roomId!.isEmpty || pw!.isEmpty{
                return false
            } else {
                if self.player!.status == .joinsuccess {
                    return true
                }
                return false
            }
        }
        return false
    }
}
