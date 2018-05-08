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
    var spy: Bool
    
    init(name:String){
        self.name = name
        self.spy = false
    }
    
    func convertToSpy() {
        spy = true
    }
    
    func revertToCiv() {
        spy = false
    }
    
    func isSpy() -> Bool {
        return spy
    }
}
