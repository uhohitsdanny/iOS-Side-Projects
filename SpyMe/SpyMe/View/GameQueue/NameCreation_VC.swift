//
//  SpyName_VC.swift
//  SpyMe
//
//  Created by Danny Navarro on 5/7/18.
//  Copyright © 2018 Danny Navarro. All rights reserved.
//

import UIKit
import CoreData

class NameCreation_VC: UIViewController {
    
    @IBOutlet weak var nameTextField: TextFieldCustom?
    @IBOutlet weak var warningLabel: UILabel?
    
    var player:Civilian? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        log("NameCreation_VC is loaded")
    }
}

// MARK: Segue Actions
extension NameCreation_VC {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "jcRmSegue" {
            if let destinationVC = segue.destination as? JoinCreateRoom_VC {
                destinationVC.player = player
            }
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "jcRmSegue"{
            
            let name = nameTextField?.text
            
            if name!.count > CHARACTER_LIMIT{
                warningLabel?.isHidden = false
                warningLabel?.text = "Max 25 characters"
                return false
            }
            
            else if name!.isEmpty {
                warningLabel?.isHidden = false
                warningLabel?.text = "A name is required"
                return false
            }
                
            else{
                player = Civilian(name: name!)
                performSegue(withIdentifier: "jcRmSegue", sender: self)
                warningLabel?.isHidden = true
                return true
            }
        }
        return false
    }
}
