//
//  SpyGame.swift
//  SpyMe
//
//  Created by Danny Navarro on 5/3/18.
//  Copyright © 2018 Danny Navarro. All rights reserved.
//

import Foundation

enum GameStatus {
    case standby
    case inprogress
    case done
}


class SpyGame: NSObject {
    let room: Room
    let locations: [String]
    let player: Civilian
    var playernames: [String]
    let chosen_loc: String
    let chosen_spy: String
    var time: TimeInterval = 0.0
    var status: GameStatus
    
    
    init(room:Room, player:Civilian){
        self.room = room
        self.locations = Locations().locations
        self.player = player
        self.playernames = room.players
        self.status = .standby
        
        self.chosen_loc = room.location
        self.chosen_spy = room.spy
    }
    
    func isFinished() -> Bool {
        if status == .done {
            return true
        }
        return false
    }
}
