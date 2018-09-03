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
    @IBOutlet weak var sendBtn: UIButton!
    
    var players: [String] = []
    var votedplayer: String = ""
    var spy: String = ""
    var player: Civilian? = nil
    var room: Room? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        log("**** VotingPopup ViewController loaded ****")
        mSetup()
    }
}

extension VotingPopup_VC {
    func mSetup()
    {
        if spy == self.player?.name
        {
            self.sendBtn.setTitle("End Game", for: .normal)
            self.sendBtn.tag = 2
        }
        else
        {
            // Change back to Send Vote, when voting API is implemented
            self.sendBtn.setTitle("End Game", for: .normal)
            self.sendBtn.tag = 1
        }
    }
}

extension VotingPopup_VC {
    @IBAction func sendVote()
    {
        if sendBtn.tag == 1
        {
            // Update voted spy in db
            
            // Remove room
            self.room?.deleteRoom(room: self.room, cb: { (success) in
                if success
                {
                    log("Successfully deleted room")
                }
            })
            // Dismiss view and go back to beginning of the storyboard
            self.view.window?.rootViewController?.dismiss(animated: true, completion: {
                log("*** Dismissing to root viewcontroller ****")
            })
        }
        else if sendBtn.tag == 2
        {
            // Remove room
            self.room?.deleteRoom(room: self.room, cb: { (success) in
                if success
                {
                    log("Successfully deleted room")
                }
            })
            // Dismiss view and go back to beginning of the storyboard
            self.view.window?.rootViewController?.dismiss(animated: true, completion: {
                log("*** Dismissing to root viewcontroller ****")
            })
        }
        
    }
}
