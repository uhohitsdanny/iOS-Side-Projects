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
    @IBOutlet weak var maxCharsLabel: UILabel?
    
    var player:Civilian? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        log("NameCreation_VC is loaded")
        nameTextField?.delegate = self
    }
    
    @IBAction func submitSpyName(){
        let name = nameTextField?.text
        if name!.count > MAX_CHARACTERS{
            
            return
        }else{
            player = Civilian(name: name!)
            performSegue(withIdentifier: "jcRmSegue", sender: self)
        }
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
}
