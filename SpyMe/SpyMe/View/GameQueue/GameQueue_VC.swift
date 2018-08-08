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
    @IBOutlet weak var startBtn: UIButton!
    
    var listRefreshTimer : Timer!
    var listrefresher : UIRefreshControl!
    var startGame : Bool = false
    var isCurrentHost : Bool = false
    
    var room : Room? = nil {
        didSet{
            log("Room \(room?.id ?? "") successfully joined.")
            mSetup()
        }
    }
    
    var player : Civilian? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        log("**** GameQueue ViewController loaded ****")
        afterLoadSetup()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        log("Invalidating timer")
        listRefreshTimer.invalidate()
    }
}

// MARK: - Setup Functions
extension GameQueue_VC {
    func mSetup()
    {
        startRefreshPlayerListTimer()
    }
    
    func afterLoadSetup()
    {
        if self.room?.host != self.player?.name
        {
            self.startBtn.isHidden = true
            self.isCurrentHost = false
        }
        else
        {
            self.startBtn.isHidden = false
            self.isCurrentHost = true
        }
    }
}

// MARK: - Interface Functions
extension GameQueue_VC {
    
    func startRefreshPlayerListTimer()
    {
        log("Starting refresh timer")
        listRefreshTimer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(refreshGameSts), userInfo: nil, repeats: true)
    }
    
    @objc func refreshGameSts()
    {
        self.room?.getUpdatedRoom(room: self.room, cb: { (success, newplayerlist, gamestatus) in
            if success
            {
                self.room?.players = newplayerlist!
                self.tableview.reloadData()

                if (gamestatus == RoomStatus.ingame) && !self.isCurrentHost
                {
                    self.room?.status = gamestatus!
                    self.goToGameRoomVc()
                }
            }
        })
    }

    func removePlayerIfDisconnected()
    {
            // TODO: Need a method to take off players if they disconnect from the app or provide a way to come back(store in local device)
    }

    func goToGameRoomVc()
    {
        self.listRefreshTimer.invalidate()
        
        // This function is for non-host players
        
        // Get chosen spy info and chosen location info
        self.room?.getSpyGameInfo(room: self.room, cb: { (success, spy, location, starttime) in
            if success
            {
                self.room?.spy = spy!
                self.room?.location = location!
                self.room?.startTime = starttime!
                
                // Init spygame and insert into the game room
                let spygame = SpyGame(room: self.room!, player: self.player!)
                let gameRoom = GameRoomViewModel(game: spygame)
                
                let modalViewCtrl = UIStoryboard(name:"Main", bundle:nil).instantiateViewController(withIdentifier:"GameRoom_VC") as! GameRoom_VC
                modalViewCtrl.gameroom_VM = gameRoom
                
                self.present(modalViewCtrl, animated: true, completion: nil)
            }
            else
            {
                self.listRefreshTimer.fire()
            }
        })
    }
}

// MARK: - Segue Actions
extension GameQueue_VC {

    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool
    {
        // This segue is specifically for the host, since the host is the one starting the game
        // The other players will rely on the timer in which it is updating the room status constantly
        // to fire the goToGameRoomVc function
        
        if identifier == "startGame"
        {

            // Pick random player to be a spy
            // Pick a random location for all players
            self.room?.spy = (self.room?.pickSpy())!
            self.room?.location = (self.room?.pickLocation())!
            
            // Refresh player list one last time
            self.room?.getUpdatedRoom(room: self.room, cb: { (success, newplayerlist, gamestatus) in
                if success
                {
                    self.room?.players = newplayerlist!
                    // * Don't grab gamestatus as it will be in standby
                    // only used for non-host players to be notified when game has started *
                    
                    self.tableview.reloadData()
                    
                    self.room?.status = .ingame
                    // Update chosen spy, chosen location and game status
                    self.room?.updateSpyGameInfo(room: self.room, cb: { (success) in
                        if success
                        {
                            
                            log("Successfully updated room")

                            // Get current time's hour, min, and seconds
                            // The app will use this to determine how much time has elapsed to sync
                            // all other players timer
                            let date = Date()
                            let calendar = Calendar.current
                            let components = calendar.dateComponents([.hour,.minute,.second], from: date)
                            let hour = components.hour
                            let minute = components.minute
                            let seconds = components.second
                            
                            self.room?.startTime = [hour,minute,seconds]
                            
                            // Update start time to sync timers
                            self.room?.updateStartTimeForRoom(room: self.room, cb: { (success) in
                                if success
                                {
                                    // Start segue to the game room
                                    self.startGame = true
                                    self.performSegue(withIdentifier: "startGame", sender: self)
                                }
                                else
                                {
                                    self.room?.status = .standby
                                    self.startGame = false
                                }
                            })
                        }
                    })
                }
            })
        }
        
        if self.startGame
        {
            return true
        }
        
        return false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "startGame"
        {
            if let destinationVC = segue.destination as? GameRoom_VC
            {
                // Init spygame and insert into the game room
                let spygame = SpyGame(room: self.room!, player: self.player!)
                let gameRoom = GameRoomViewModel(game: spygame)
                destinationVC.gameroom_VM = gameRoom
            }
        }
    }
}
