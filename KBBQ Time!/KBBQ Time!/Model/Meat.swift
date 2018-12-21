//
//  Meat.swift
//  KBBQ Time!
//
//  Created by Danny Navarro on 12/17/18.
//  Copyright © 2018 Squirrel. All rights reserved.
//

import Foundation

enum MeatType
{
    case beef
    case pork
    case chicken
    case seafood
}

class Meat
{
    var meatType : MeatType!
    var fliptime : Int = 0
    
    init(mtype:MeatType)
    {
        meatType = mtype
        
        switch meatType!
        {
        case .beef:
            fliptime = 120
            break
        case .pork:
            fliptime = 120
            break
        case .chicken:
            fliptime = 240
            break
        case .seafood:
            fliptime = 240
            break
        }
    }
}
