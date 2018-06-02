//
//  ConnectionRoom_VC.swift
//  SpyMe
//
//  Created by Danny Navarro on 6/1/18.
//  Copyright © 2018 Danny Navarro. All rights reserved.
//

import UIKit

class ConnRoom_VC: UIViewController {

    var player: Civilian? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        log("ConnRoom View Controller loaded")
    }
}

extension ConnRoom_VC {
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "joinGameQueue" {
            return true
        }
        return false
    }
}
