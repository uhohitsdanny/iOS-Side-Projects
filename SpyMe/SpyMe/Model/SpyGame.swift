//
//  SpyGame.swift
//  SpyMe
//
//  Created by Danny Navarro on 5/3/18.
//  Copyright © 2018 Danny Navarro. All rights reserved.
//

import Foundation

enum GameStatus {
    case waiting
    case ready
    case inProgress
    case done
}


class SpyGame: NSObject {
    let room: Room
    let locations: Locations
    let player: Civilian
    var civs: [Civilian]
    var status: GameStatus
    
    
    init(room:Room, player:Civilian){
        self.room = room
        self.locations = Locations()
        self.player = player
        self.civs = []
        self.status = .waiting
    }
    
    func startGame() -> Bool { return false }
    func chckRmSts() -> RoomStatus { return .pending}
    func pickSpy() -> Bool { return false }
    func startTimer() {}
    func isFinished() -> Bool {
        if status == .done {
            return true
        }
        return false
    }
}
