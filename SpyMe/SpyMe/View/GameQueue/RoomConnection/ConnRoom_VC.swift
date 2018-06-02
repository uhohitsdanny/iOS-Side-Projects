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
        log("ConnRoom View Controller loaded")
        roomIdTextField?.delegate = self
    }
    
    @IBAction func joinRoom(){
        // Query DB for the room
        room?.id = (roomIdTextField?.text)!
        room?.pw = (pwTextField?.text)!
    }
}

extension ConnRoom_VC {
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "joinGameQueue" {
            let roomId = roomIdTextField?.text
            let pw = pwTextField?.text
            if roomId!.isEmpty || pw!.isEmpty{
                return false
            } else {
                if self.room?.status == .success {
                    return true
                }
                return false
            }
        }
        return false
    }
}
