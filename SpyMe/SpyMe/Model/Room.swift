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
                    // Room exists, check if it's outdated (over 60 mins old),
                    // if so, delete the room
                    // We do this because of the case when the user
                    // force-terminates the app after room creation without starting the game
                    // Get current time and time of room creation
                    let date = Date()
                    let calendar = Calendar.current
                    let components = calendar.dateComponents([.year,.month,.day,.hour,.minute,.second], from: date)
                    
                    let roomdate = objects![0].createdAt
                    let roomcomponents = calendar.dateComponents([.year,.month,.day,.hour,.minute,.second], from: roomdate!)
                    
                    // short-circuit evaluation will catch this in order (conditions are read left to right)
                    if (roomcomponents.year! < components.year!) || (roomcomponents.month! < components.month!) || (roomcomponents.day! < components.day!)
                    {
                        // Room is too old, delete
                        objects![0].deleteInBackground(block: { (success, error) in
                            if error == nil
                            {
                                if success { log("Deleted object successfully") }
                                else { log("Deleted object unsuccessfully") }
                            }
                            else
                            {
                                log("Deleted object unsuccessfully")
                            }
                        })
                    }
                    else
                    {
                        // this else statement means, the room was created on the same day
                        // now we check if it has surpassed 60 minutes, if so then delete
                        // Get difference between time (The hour is calculated in 24-hour system)
                        let oldRoomSeconds = (roomcomponents.hour! * 60 * 60) + (roomcomponents.minute! * 60) + roomcomponents.second!
                        
                        let currentSeconds = (components.hour! * 60 * 60) + (components.minute! * 60) + components.second!
                        
                        if (abs(currentSeconds) - abs(oldRoomSeconds)) > (60 * 60)
                        {
                            // Room is too old, delete
                            objects![0].deleteInBackground(block: { (success, error) in
                                if error == nil
                                {
                                    if success
                                    {
                                        log("Deleted object successfully")
                                    }
                                    else
                                    {
                                        log("Deleted object unsuccessfully")
                                    }
                                }
                                else
                                {
                                    log("Deleted object unsuccessfully")
                                }
                            })
                        }
                    }
                    
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
                newRoomObj["starttime"] = room!.startTime
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
                        room.startTime = objects![0].object(forKey: "starttime") as! [Int?]
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
    
    func deleteRoom(room:Room?,cb:@escaping (Bool)->Void)
    {
        let query = PFQuery(className: "Room")
        query.whereKey("roomid", equalTo: (room?.id)!)
        query.findObjectsInBackground { (objects, error) in
            if error == nil
            {
                if !(objects?.isEmpty)!
                {
                    log("Parse query was successful")
                    log("Attempting to delete object")
                    let objToDelete = objects![0]
                    objToDelete.deleteInBackground(block: { (success, error) in
                        if error == nil
                        {
                            if success
                            {
                                log("Deleted object successfully")
                                cb (true)
                            }
                            else
                            {
                                log("Deleted object unsuccessfully")
                                cb (false)
                            }
                        }
                        else
                        {
                            log("Deleted object unsuccessfully")
                            cb (false)
                        }
                    })
                }
                else
                {
                    log("Queried objects is empty.")
                    log("----------------------------")
                    print(error ?? "")
                    
                    cb (false)
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
    
    // MARK: - Update Functions
    
    func updateSpyGameInfo(room:Room?,cb:@escaping (Bool)->Void)
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
                    newRoomObj["status"] = room?.status.rawValue
                    newRoomObj.saveInBackground(block: { (success, error) in
                        if error == nil
                        {
                            if success
                            {
                                log("Successfully updated spygame information")
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
                            log("\(String(describing: error))")
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
                    newRoomObj.saveInBackground(block: { (success, error) in
                        if error == nil
                        {
                            if success
                            {
                                log("Successfully updated start time")
                                
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
    
    func updateVotedSpy(room:Room?,cb:@escaping (Bool)->Void)
    {
        let query = PFQuery(className: "Room")
        query.whereKey("roomid", equalTo: (room?.id)!)
    }
    
    // MARK: - Get Functions
    
    func getSpyGameInfo(room:Room?,cb:@escaping (Bool,String?,String?,[Int?]?)->Void)
    {
        let query = PFQuery(className: "Room")
        query.whereKey("roomid", equalTo: (room?.id)!)
        query.findObjectsInBackground { (objects, error) in
            if error == nil
            {
                if !(objects?.isEmpty)!
                {
                    log("Successfully queried spygame information")

                    let chosen_spy = objects![0].object(forKey: "spy") as! String
                    let chosen_location = objects![0].object(forKey: "location") as! String
                    let starttime = objects![0].object(forKey: "starttime") as! [Int?]
                    
                    cb (true,chosen_spy,chosen_location,starttime)
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
    
    func getUpdatedRoom(room:Room?,cb:@escaping (Bool,[String]?,RoomStatus?)->Void)
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
                    
                    cb (true,playerlist,gamestatus)
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
