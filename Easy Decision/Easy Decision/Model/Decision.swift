//
//  Decision.swift
//  Easy Decision
//
//  Created by Danny Navarro on 2/15/18.
//

import Foundation

struct Decision {
    
    private var dId: Int?
    private var img: String?
    private var str: String = ""
    private var sts: NSNumber?
    
}

extension Decision {
    
    func getId() -> Int {
        return self.dId!
    }
    
    func getImg() -> String {
        return self.img!
    }
    
    func getDecision() -> String {
        return self.str
    }
    
    func getSts() -> NSNumber {
        return self.sts!
    }
}
