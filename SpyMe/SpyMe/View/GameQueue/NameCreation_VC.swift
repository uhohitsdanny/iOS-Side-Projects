//
//  SpyName_VC.swift
//  SpyMe
//
//  Created by Danny Navarro on 5/7/18.
//  Copyright © 2018 Danny Navarro. All rights reserved.
//

import UIKit

class NameCreation_VC: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField?
    
    var player:Civilian? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        log("NameCreation_VC is loaded")
    }
    
    
    @IBAction func submitSpyName(){
        let name = nameTextField?.text
        player = Civilian(name: name!)
        performSegue(withIdentifier: "roomSegue", sender: self)
    }

}

// MARK: Segue Actions
extension NameCreation_VC {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "roomSegue" {
            if let destinationVC = segue.destination as? JoinCreateRoom_VC {
                destinationVC.player = player
            }
        }
    }
}
