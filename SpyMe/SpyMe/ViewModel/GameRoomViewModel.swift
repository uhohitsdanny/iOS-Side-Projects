//
//  GameRoomViewModel.swift
//  SpyMe
//
//  Created by Danny Navarro on 5/5/18.
//  Copyright © 2018 Danny Navarro. All rights reserved.
//

import Foundation

class GameRoomViewModel: NSObject, GameRoomProtocol {
    
    let spygame: SpyGame
    
    // MARK: GameRoomViewModel protocol
    var role: String
    var time: Int
    var locs: Locations
    var selectedLoc: String
    
    var isFinished: Bool
    
    // MARK: Init
    init(game:SpyGame, selLoc:String){
        self.spygame = game
        self.selectedLoc = selLoc
        self.role = game.player.role
        self.time = 480
        self.locs = game.locations
        self.isFinished = game.isFinished()
    }
}
