//
//  GameQueueViewController.swift
//  SpyMe
//
//  Created by Danny Navarro on 5/7/18.
//  Copyright © 2018 Danny Navarro. All rights reserved.
//

import UIKit

class GameQueue_VC: UIViewController {

    @IBOutlet weak var tableview: UITableView!
    
    var listRefreshTimer : Timer!
    var listrefresher : UIRefreshControl!
    
    var room : Room? = nil {
        didSet{
            log("Room \(room?.id ?? "") successfully joined.")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        log("**** GameQueue ViewController loaded ****")
        mSetup()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        log("Invalidating timer")
        listRefreshTimer.invalidate()
    }
}

extension GameQueue_VC {
    
    // TODO: Need a method to refresh player list every 3 seconds
    func startRefreshPlayerListTimer()
    {
        log("Starting timer")
        listRefreshTimer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(refreshPlayerList), userInfo: nil, repeats: true)
    }
    
    @objc func refreshPlayerList()
    {
        self.room?.getPlayerList(room: self.room, cb: { (success, newplayerlist) in
            if success
            {
                self.room?.players = newplayerlist!
                self.tableview.reloadData()
            }
        })
    }
    
    // TODO: Need a method to take off players if they disconnect from the app or provide a way to come back(store in local device)
    func removePlayerIfDisconnected()
    {
        
    }

    func mSetup()
    {
        startRefreshPlayerListTimer()
    }
}
