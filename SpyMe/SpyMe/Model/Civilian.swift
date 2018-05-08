//
//  Civilian.swift
//  SpyMe
//
//  Created by Danny Navarro on 5/3/18.
//  Copyright © 2018 Danny Navarro. All rights reserved.
//

import Foundation

class Civilian: NSObject {
    
    let name: String
    var role: String
    var spy: Bool
    
    init(name:String){
        self.name = name
        self.role = "Civilian"
        self.spy = false
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