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
        log("**** GameRoom ViewController loaded ****")
        setupGameUI()
    }
    
    fileprivate func setupGameUI()
    {
        if !isViewLoaded {
            return
        }
        
        guard gameroom_VM != nil else { return }
        
        gameroom_VM?.time.bindAndFire({ [unowned self] in self.timeLabel.text = $0 })
        gameroom_VM?.isFinished.bindAndFire({ [unowned self] in self.goToVotingVC($0) })
        
        self.locationLabel.text = gameroom_VM?.loc
        self.roleLabel.text = gameroom_VM?.role
        
        gameroom_VM?.startTimer()
    }
    
    fileprivate func goToVotingVC(_ finished:Bool)
    {
        if finished
        {
            // Pop up voting vc
            let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let popupVC = storyboard.instantiateViewController(withIdentifier: "VotingPopup_VC") as! VotingPopup_VC
            popupVC.spy = (self.gameroom_VM?.spygame.chosen_spy)!
            popupVC.players = (self.gameroom_VM?.spygame.playernames)!
            popupVC.player = (self.gameroom_VM?.spygame.player)!
            popupVC.room = (self.gameroom_VM?.spygame.room)!
            
            self.addChildViewController(popupVC)
            popupVC.view.frame = self.view.frame
            self.view.addSubview(popupVC.view)
            popupVC.didMove(toParentViewController: self)
        }        
        // After pop up is done, delete game room from DB
    }
    
}
