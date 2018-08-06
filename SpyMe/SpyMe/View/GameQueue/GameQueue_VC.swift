//
//  GameQueueViewController.swift
//  SpyMe
//
//  Created by Danny Navarro on 5/7/18.
//  Copyright © 2018 Danny Navarro. All rights reserved.
//

import UIKit

class GameQueue_VC: UIViewController {

    var room : Room? = nil {
        didSet{
            log("Room \(room?.id ?? "") successfully joined.")
            mSetup()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        log("**** GameQueue ViewController loaded ****")
        // Do any additional setup after loading the view.
    }
}

extension GameQueue_VC {
    
    func mSetup()
    {
        
    }
}
