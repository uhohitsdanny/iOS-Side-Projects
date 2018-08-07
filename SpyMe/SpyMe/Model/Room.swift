//
//  Room.swift
//  SpyMe
//
//  Created by Danny Navarro on 5/3/18.
//  Copyright © 2018 Danny Navarro. All rights reserved.
//

import Parse

enum RoomStatus: String {
    case standby = "standby"
    case ingame = "ingame"
}

class Room: NSObject {
    var id: String
    var pw: String
    var host: String
    var status: RoomStatus
    var seconds: Int
    var startTime: [Int?]
    var players:[String]
    
    var spy:String
    var location:String

    init(id:String, pw:String){
        self.id = id
        self.pw = pw
        self.host = ""
        self.status = .standby
        self.seconds = DEFAULT_TIME
        self.startTime = []
        self.players = []
        
        self.spy = ""
        self.location = ""
    }
    
    // MARK: Parse
    func createRoom(room:Room?,completion:@escaping (Bool, Bool)->Void)
    {
        
        let query = PFQuery(className: "Room")
        
        // Check if Room ID is already taken by querying
        query.whereKey("roomid", equalTo: (room?.id)!)
        query.findObjectsInBackground { (objects, error) in
            if error == nil
            {
                if !(objects?.isEmpty)!
                {
                    let roomid = objects![0].object(forKey: "roomid") as! String
                    log("Parse query was successful")
                    log("Room ID " + roomid + " already exists")
                    completion(false,true)
                    return
                }
                
                // Else if objects equals nil, then the room did not exists
                // Save room obj into Room class in the Parse DB
                let newRoomObj = PFObject(className: "Room")
                newRoomObj["roomid"] = room!.id
                newRoomObj["pw"] = room!.pw
                newRoomObj["host"] = room!.host
                newRoomObj["status"] = room!.status.rawValue
                newRoomObj["time"] = room!.seconds
                newRoomObj["players"] = room!.players
                
                newRoomObj.saveInBackground(block: { (success, error) in
                    if error == nil
                    {
                        completion(true,false)
                    }
                    else
                    {
                        completion(false,false)
                        
                        log("\(String(describing: error))")
                    }
                })
            }
            else
            {
                log("Querying Room objects failed")
                log("----------------------------")
                print(error ?? "")
                
                completion(false,true)
            }
        }
    }
    
    func joinRoom(player:String,completion:@escaping (Bool?,Bool,Room?)->Void)
    {
        let validPassword = true
        let joined = true
        
        let room = Room(id: self.id, pw: self.pw)
        
        let query = PFQuery(className: "Room")
        query.whereKey("roomid", equalTo: room.id)
        query.findObjectsInBackground { (objects, error) in
            if error == nil
            {
                if !(objects?.isEmpty)!
                {
                    log("Parse query was successful")
                    
                    // Check if password matches
                    let password = objects![0].object(forKey: "pw") as! String
                    
                    if room.pw == password
                    {
                        room.host = objects![0].object(forKey: "host") as! String
                        room.status =  RoomStatus(rawValue: objects![0].object(forKey: "status") as! String)!
                        room.seconds = objects![0].object(forKey: "time") as! Int
                        room.players = objects![0].object(forKey: "players") as! [String]
                        
                        room.players.append(player)
                        
                        // After querying the room, we must update it with the new player list
                        let newRoomObj = objects![0]
                        newRoomObj["players"] = room.players
                        newRoomObj.saveInBackground(block: { (success, error) in
                            if error == nil
                            {
                                log("Successfully updated with new player list: " + room.players.description)
                                completion(validPassword,joined,room)
                            }
                            else
                            {
                                log("Could not join room")
                            }
                        })
                        
                    }
                    
                    else
                    {
                        completion(!validPassword,!joined,room)
                    }
                }
            }
            else
            {
                log("Querying Room objects failed")
                log("----------------------------")
                print(error ?? "")
                
                completion(nil,!joined,nil)
            }
        }
    }
    
    // MARK: - Update Functions
    
    func updateSpyAndLocation(room:Room?,cb:@escaping (Bool)->Void)
    {
        let query = PFQuery(className: "Room")
        query.whereKey("roomid", equalTo: (room?.id)!)
        query.findObjectsInBackground { (objects, error) in
            if error == nil
            {
                if !(objects?.isEmpty)!
                {
                    let newRoomObj = objects![0]
                    newRoomObj["spy"] = room?.spy
                    newRoomObj["location"] = room?.location
                    newRoomObj.saveInBackground(block: { (success, error) in
                        if error != nil
                        {
                            if success
                            {
                                cb(true)
                            }
                            else
                            {
                                cb (false)
                            }
                        }
                        else
                        {
                            log("Error: could not update chosen spy and location")
                            cb (false)
                        }
                    })
                }
            }
            else
            {
                log("Querying Room objects failed")
                log("----------------------------")
                print(error ?? "")
                cb (false)
            }
        }
    }
    
    func updateStartTimeForRoom(room:Room?,cb:@escaping (Bool)->Void)
    {
        let query = PFQuery(className: "Room")
        query.whereKey("roomid", equalTo: (room?.id)!)
        query.findObjectsInBackground { (objects, error) in
            if error == nil
            {
                if !(objects?.isEmpty)!
                {
                    let newRoomObj = objects![0]
                    newRoomObj["starttime"] = room?.startTime
                    newRoomObj["status"] = room?.status
                    newRoomObj.saveInBackground(block: { (success, error) in
                        if error != nil
                        {
                            if success
                            {
                                cb(true)
                            }
                            else
                            {
                                cb (false)
                            }
                        }
                        else
                        {
                            log("Error: could not update start time.")
                            cb (false)
                        }
                    })
                }
            }
            else
            {
                log("Querying Room objects failed")
                log("----------------------------")
                print(error ?? "")
                cb (false)
            }
        }
    }
    
    // MARK: - Get Functions
    
    func getSpyAndLocation(room:Room?,cb:@escaping (Bool,String?,String?)->Void)
    {
        let query = PFQuery(className: "Room")
        query.whereKey("roomid", equalTo: (room?.id)!)
        query.findObjectsInBackground { (objects, error) in
            if error == nil
            {
                if !(objects?.isEmpty)!
                {
                    let chosen_spy = objects![0].object(forKey: "spy") as! String
                    let chosen_location = objects![0].object(forKey: "location") as! String

                    cb (true,chosen_spy,chosen_location)
                }
            }
            else
            {
                log("Querying Room objects failed")
                log("----------------------------")
                print(error ?? "")
                cb (false,nil,nil)
            }
        }
    }
    
    func getUpdatedRoom(room:Room?,cb:@escaping (Bool,[String]?,RoomStatus?,[Int?]?)->Void)
    {
        let query = PFQuery(className: "Room")
        query.whereKey("roomid", equalTo: (room?.id)!)
        query.findObjectsInBackground { (objects, error) in
            if error == nil
            {
                if !(objects?.isEmpty)!
                {
                    let playerlist = objects![0].object(forKey: "players") as! [String]
                    let gamestatus = RoomStatus(rawValue: objects![0].object(forKey: "status") as! String)!
                    let starttime = objects![0].object(forKey: "starttime") as! [Int?]
                    
                    cb (true,playerlist,gamestatus,starttime)
                }
            }
            else
            {
                log("Querying Room objects failed")
                log("----------------------------")
                print(error ?? "")
                cb (false,nil,nil,nil)
            }
        }
    }
    
    // MARK: - Picking Functions
    
    func pickSpy() -> String
    {
        let randomIndex = Int(arc4random_uniform(UInt32(self.players.count)))
        return self.players[randomIndex]
    }
    
    func pickLocation() -> String
    {
        return Locations().getRandomLocation()
    }
}
