//
//  GRProtocol.swift
//  SpyMe
//
//  Created by Danny Navarro on 5/6/18.
//  Copyright © 2018 Danny Navarro. All rights reserved.
//

import Foundation

protocol GameRoomProtocol{
    var role:String         { get }
    var time:String         { get }
    var locs:Locations      { get }
    var selectedLoc:String  { get }
    
    var isFinished:Bool     { get }
}
