//
//  SpyRoom_VC.swift
//  SpyMe
//
//  Created by Danny Navarro on 5/7/18.
//  Copyright © 2018 Danny Navarro. All rights reserved.
//

import UIKit

class JoinCreateRoom_VC: UIViewController {

    var player:Civilian? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        log("**** JoinCreateRoom ViewController loaded ****")
    }
}

// MARK: - Button Functions

extension JoinCreateRoom_VC {
    
    @IBAction func dismissViewController()
    {
        self.dismiss(animated: true) {
            log("**** JoinCreateRoom ViewController dismissed ****")
        }
    }
}

// MARK: - Segue Actions
extension JoinCreateRoom_VC {
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if player != nil {
            return true
        }
        return false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "connRmSegue" {
            if let destinationVC = segue.destination as? ConnRoom_VC {
                destinationVC.player = player
            }
        }
        
        else if segue.identifier == "createRmSegue" {
            if let destinationVC = segue.destination as? RoomCreation_VC {
                destinationVC.player = player
            }
        }
    }
}
