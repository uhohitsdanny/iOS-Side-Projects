//
//  RoomCreation_VC.swift
//  SpyMe
//
//  Created by Danny Navarro on 5/7/18.
//  Copyright © 2018 Danny Navarro. All rights reserved.
//

import UIKit

class RoomCreation_VC: UIViewController {

    var player: Civilian? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        log("RoomCreation View Controller loaded")
    }
}

extension RoomCreation_VC {
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "createGameQueue" {
            return true
        }
        return false
    }
}
