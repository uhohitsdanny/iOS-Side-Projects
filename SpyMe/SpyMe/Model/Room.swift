//
//  Room.swift
//  SpyMe
//
//  Created by Danny Navarro on 5/3/18.
//  Copyright © 2018 Danny Navarro. All rights reserved.
//

import Foundation

enum RoomStatus {
    case pending
    case success
    case fail
}

class Room: NSObject {
    var id: String
    var pw: String
    var status: RoomStatus
    
    init(id:String){
        self.id = id
        self.pw = ""
        self.status = .pending
    }
    
    // MARK: Bluetooth interactions
    func createRoom() {}
    func joinRoom() {}
}
