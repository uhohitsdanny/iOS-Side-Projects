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
    var time: String
    var locs: [String]
    
    var isFinished: Bool
    
    // MARK: Init
    init(game:SpyGame){
        self.spygame = game
        self.role = game.player.role
        self.time = GameRoomViewModel.timeRemaining(for: game)
        self.locs = game.locations
        self.isFinished = game.isFinished()
    }
    
    // MARK: Private
    fileprivate var gameTimer: Timer?
    
    fileprivate func startTimer() {
        let interval: TimeInterval = 0.001
        gameTimer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true, block: { (timer) in
            self.spygame.time += interval
            self.time = GameRoomViewModel.timeRemaining(for: self.spygame)
        })
    }
    
    fileprivate static func timeFormatted(totalMillis: Int) -> String {
        let millis: Int = totalMillis % 1000 / 100 // "/ 100" <- because we want only 1 digit
        let totalSeconds: Int = totalMillis / 1000
        
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60)
        
        return String(format: "%02d:%02d.%d", minutes, seconds, millis)
    }
    
    fileprivate static func timeRemaining(for game: SpyGame) -> String{
        return timeFormatted(totalMillis: Int(game.time * 1000))
    }
}
