//
//  GameRoomViewController.swift
//  SpyMe
//
//  Created by Danny Navarro on 5/7/18.
//  Copyright © 2018 Danny Navarro. All rights reserved.
//

import UIKit

class GameRoom_VC: UIViewController {
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var roleLabel: UILabel!
    
    var gameroom_VM: GameRoomViewModel? {
        didSet {
            setupGameUI()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupGameUI()
    }
    
    fileprivate func setupGameUI()
    {
        if !isViewLoaded {
            return
        }
        
        guard gameroom_VM != nil else { return }
        
        self.timeLabel.text = gameroom_VM?.time
        self.locationLabel.text = gameroom_VM?.loc
        self.roleLabel.text = gameroom_VM?.role
        
        startTimer()
    }
    
    fileprivate func startTimer()
    {
        gameroom_VM?.startTimer()
    }

}
