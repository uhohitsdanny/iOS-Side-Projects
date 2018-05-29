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
    
    var player:Civilian? = nil
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        log("NameCreation_VC is loaded")
        
    }
    
    @IBAction func submitSpyName(){
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Users", in: context)
        let newUser = NSManagedObject(entity: entity!, insertInto: context)
        let name = nameTextField?.text
        
        newUser.setValue(name, forKey: "spyname")
        player = Civilian(name: name!)
        
        performSegue(withIdentifier: "jcRmSegue", sender: self)
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
