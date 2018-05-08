//
//  GQProtocol.swift
//  SpyMe
//
//  Created by Danny Navarro on 5/6/18.
//  Copyright © 2018 Danny Navarro. All rights reserved.
//

import Foundation

protocol GameQueueProtocol {
    var players:[String]    { get }
    var isReady:Bool        { get }
    
    func toggleStart()
}
