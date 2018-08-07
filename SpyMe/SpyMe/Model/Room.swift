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
    case ready = "ready"
    case ingame = "ingame"
}

class Room: NSObject {
    var id: String
    var pw: String
    var host: String
    var status: RoomStatus
    var seconds: Int
    var startTime: Any?
    var players:[String]

    init(id:String, pw:String){
        self.id = id
        self.pw = pw
        self.host = ""
        self.status = .standby
        self.seconds = DEFAULT_TIME
        self.players = []
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
                            }
                            else
                            {
                                log("\(String(describing: error))")
                            }
                        })
                        
                        completion(validPassword,joined,room)
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
    
    func getPlayerList(room:Room?,cb:@escaping (Bool,[String]?)->Void)
    {
        let query = PFQuery(className: "Room")
        
        query.whereKey("roomid", equalTo: (room?.id)!)
        query.findObjectsInBackground { (objects, error) in
            if error == nil
            {
                if !(objects?.isEmpty)!
                {
                    let playerlist = objects![0].object(forKey: "players") as! [String]
                    
                    cb (true,playerlist)
                }
            }
            else
            {
                log("Querying Room objects failed")
                log("----------------------------")
                print(error ?? "")
                cb (false,nil)
            }
        }
    }
}
