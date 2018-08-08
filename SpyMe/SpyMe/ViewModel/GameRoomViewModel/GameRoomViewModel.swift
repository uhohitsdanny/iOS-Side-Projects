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
    var time: Dynamic<String>
    var loc: String
    var locs: [String]
    
    var isFinished: Dynamic<Bool>
    
    // MARK: Init
    init(game:SpyGame){
        self.spygame = game
        self.role = GameRoomViewModel.getRole(spyname: game.chosen_spy, playername: game.player.name)
        
        // sync timer from current time - start time
        game.time = GameRoomViewModel.syncTimer(startTime: game.room.startTime, time: game.room.seconds)
        self.time = Dynamic(GameRoomViewModel.timeRemaining(for: game))
        
        self.loc = GameRoomViewModel.getLocation(location: game.chosen_loc, spyname: game.chosen_spy, playername: game.player.name)
        self.locs = game.locations
        self.isFinished = Dynamic(game.isFinished())
    }
    
    // MARK: Private
    fileprivate var gameTimer: Timer?
    
    func startTimer() {
        let interval: TimeInterval = 0.001
        
        log("*** Starting Game Timer ***")
        gameTimer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true, block: { (timer) in
            self.spygame.time -= interval
            

            if self.spygame.time == 0
            {
                self.pauseTimer()
                self.time.value = GameRoomViewModel.timeRemaining(for: self.spygame)
            }
            else if self.spygame.time <= 0
            {
                self.pauseTimer()
            }
            else
            {
                self.time.value = GameRoomViewModel.timeRemaining(for: self.spygame)
            }
        })
    }
    
    fileprivate func pauseTimer() {
        gameTimer?.invalidate()
        gameTimer = nil
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
    
    fileprivate static func syncTimer(startTime:[Int?], time:Int) -> TimeInterval
    {
        // Get current time
        let date = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour,.minute,.second], from: date)
        
        // Get difference between time (The hour is calculated in 24-hour system)
        let dHour = components.hour! - startTime[0]!
        let dMinute = components.minute! - startTime[1]!
        let dSeconds = components.second! - startTime[2]!
        
        // Convert to seconds
        let convertedSeconds = (dHour * 3600) + (dMinute * 60) + dSeconds
        
        // Subtract the converted seconds from the timer's seconds and return
        return Double((time - convertedSeconds))
    }
    
    fileprivate static func getRole(spyname:String, playername:String) -> String
    {
        if spyname == playername
        {
            return "You are the SPY!"
        }
        else
        {
            return "You are NOT the spy!"
        }
    }
    
    fileprivate static func getLocation(location:String,spyname:String, playername:String) -> String
    {
        if spyname == playername
        {
            return ""
        }
        else
        {
            return "\" \(location) \""
        }
    }
}
