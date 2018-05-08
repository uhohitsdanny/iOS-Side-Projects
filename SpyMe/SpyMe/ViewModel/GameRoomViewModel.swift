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
    var locs: [String]
    var selectedLoc: String
    
    var isFinished: Bool
    
    // MARK: Init
    init(game:SpyGame){
        self.spygame = game
        self.role =
    }
}
