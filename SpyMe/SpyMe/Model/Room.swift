//
//  Room.swift
//  SpyMe
//
//  Created by Danny Navarro on 5/3/18.
//  Copyright © 2018 Danny Navarro. All rights reserved.
//

import Parse

enum RoomStatus {
    case standby
    case ready
    case ingame
}

class Room: NSObject {
    var id: String
    var pw: String
    var status: RoomStatus
    
    init(id:String){
        self.id = id
        self.pw = ""
        self.status = .standby
    }
    
    // MARK: Parse
    func createRoom(room:Room?,completion:@escaping (Bool)->Void) {
        
        let query = PFQuery(className: "Room")
        
        // Check if Room ID is already taken
        query.whereKey("roomid", equalTo: (room?.id)!)
        query.findObjectsInBackground { (objects, error) in
            if error == nil {
                let roomid = objects![0].object(forKey: "roomid") as! String
                log("Parse query was successful")
                log("Found room ID " + roomid)
                
                completion(true)
            }
            else {
                log("Querying Room objects failed")
                log("----------------------------")
                print(error ?? "")
                
                completion(false)
            }
        }
    }
    func joinRoom() {}
}
