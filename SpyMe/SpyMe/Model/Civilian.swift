//
//  Civilian.swift
//  SpyMe
//
//  Created by Danny Navarro on 5/3/18.
//  Copyright © 2018 Danny Navarro. All rights reserved.
//

import Foundation


enum PlayerStatus {
    case joinsuccess
    case standby
    case ingame
}

class Civilian: NSObject {
    
    let name: String
    var role: String
    var spy: Bool
    var roomid: String?
    var status: PlayerStatus
    
    
    init(name:String){
        self.name = name
        self.role = "Civilian"
        self.spy = false
        self.roomid = nil
        self.status = .standby
    }
    
    func convertToSpy() {
        spy = true
        role = "Spy"
    }
    
    func revertToCiv() {
        spy = false
        role = "Civilian"
    }
    
    func isSpy() -> Bool {
        return spy
    }
}
