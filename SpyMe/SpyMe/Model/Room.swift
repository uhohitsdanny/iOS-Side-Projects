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
    var status: RoomStatus
    var seconds: Int
    
    init(id:String){
        self.id = id
        self.pw = ""
        self.status = .standby
        self.seconds = DEFAULT_TIME
    }
    
    // MARK: Parse
    func createRoom(room:Room?,completion:@escaping (Bool, Bool)->Void) {
        
        let query = PFQuery(className: "Room")
        
        // Check if Room ID is already taken by querying
        query.whereKey("roomid", equalTo: (room?.id)!)
        query.findObjectsInBackground { (objects, error) in
            if error == nil
            {
                if !(objects?.isEmpty)!
                {
                    log("\(objects?.description ?? "test test")")
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
                newRoomObj["status"] = room!.status.rawValue
                newRoomObj["time"] = room!.seconds
                
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
    func joinRoom() {}
}
