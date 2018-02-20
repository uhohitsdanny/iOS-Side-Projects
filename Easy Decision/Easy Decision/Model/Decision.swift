//
//  Decision.swift
//  Easy Decision
//
//  Created by Danny Navarro on 2/15/18.
//

import Foundation

enum Status: Int {
    case idle   = 0
    case fetching
    case ready
    case done
    case networkNotAvailable
    case noDataAvailable
    case reqTimeout
}



class Decision {
    
    private var dId: Int = 0
    private var img: String?
    private var str: String = ""
    private var sts: Status?
    
    init(id:Int) {
        self.dId = id
    }

}

extension Decision {
    
//    func get decisionList() -> [Decision] {
//        return self
//    }
    
}
