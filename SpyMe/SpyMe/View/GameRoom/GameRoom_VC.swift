//
//  GameRoomViewController.swift
//  SpyMe
//
//  Created by Danny Navarro on 5/7/18.
//  Copyright © 2018 Danny Navarro. All rights reserved.
//

import UIKit

class GameRoom_VC: UIViewController {
    
    var gameroom_VM: GameRoomViewModel? {
        didSet {
            setupGameUI()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupGameUI()
    }
    
    fileprivate func setupGameUI() {
        if !isViewLoaded {
            return
        }
        
        guard gameroom_VM != nil else { return }
    }

}
