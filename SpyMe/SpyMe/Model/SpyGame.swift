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
    let locations: Locations
    let player: Civilian
    var civs: [Civilian]
    
    var time: TimeInterval = 0.0
    var status: GameStatus = .standby
    
    
    init(room:Room, player:Civilian){
        self.room = room
        self.locations = Locations()
        self.player = player
        self.civs = []
    }
    
    func startGame() -> Bool { return false }
    func chckRmSts() -> RoomStatus { return .standby}
    func pickSpy() -> Bool { return false }

    func isFinished() -> Bool {
        if status == .done {
            return true
        }
        return false
    }
}
