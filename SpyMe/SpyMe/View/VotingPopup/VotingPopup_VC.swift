//
//  VotingPopup_VC.swift
//  SpyMe
//
//  Created by Danny Navarro on 8/9/18.
//  Copyright © 2018 Danny Navarro. All rights reserved.
//

import UIKit

class VotingPopup_VC: UIViewController {
    
    @IBOutlet weak var tableview: UITableView!
    
    var players: [String] = []
    var votedplayer: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        mSetup()
    }
}

extension VotingPopup_VC {
    func mSetup()
    {
    }
}

extension VotingPopup_VC {
    @IBAction func sendVote()
    {
        // update voted spy in db
        
    }
}
