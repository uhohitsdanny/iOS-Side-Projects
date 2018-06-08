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
    
    var player: Civilian? = nil
    var room: Room? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        log("RoomCreation View Controller loaded")
        roomIdTextField?.delegate = self
    }
    
    @IBAction func createRoom(){
        //Add room id to table
        room?.id = (roomIdTextField?.text)!
        room?.pw = (pwTextField?.text)!
    }
}

extension RoomCreation_VC {
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "createGameQueue" {
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
