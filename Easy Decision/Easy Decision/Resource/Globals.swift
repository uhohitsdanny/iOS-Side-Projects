//
//  Globals.swift
//  Easy Decision
//
//  Created by Danny Navarro on 2/27/18.
//

import Foundation

enum Status: NSNumber {
    case idle   = 0
    case fetching
    case ready
    case done
    case networkNotAvailable
    case noDataAvailable
    case reqTimeout
}

// Persistent Data
let recentDecisionList: [Decision] = [Decision()]

//Global Functions
// I like logs:D
func log(_ statement:String){
    print(statement)
}

