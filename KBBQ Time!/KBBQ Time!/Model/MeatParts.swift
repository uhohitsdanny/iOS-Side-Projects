//
//  MeatParts.swift
//  KBBQ Time!
//
//  Created by Danny Navarro on 12/19/18.
//  Copyright © 2018 Squirrel. All rights reserved.
//

import Foundation

protocol MeatPartType
{
    var rawValue : String { get }
}

enum MeatParts
{
    enum beef : String, CaseIterable, MeatPartType
    {
        case brisket = "Brisket"
        case tongue = "Tongue"
    }
    
    enum pork : String, CaseIterable, MeatPartType
    {
        case porkbelly = "Porkbelly"
        case bacon = "Bacon"
        case jowel = "Jowel"
    }
    
    enum chicken : String, CaseIterable, MeatPartType
    {
        case spicychicken = "Spicy Chicken"
        case garlicchicken = "Garlic Chicken"
    }
    
    enum seafood : String, CaseIterable, MeatPartType
    {
        case shrimp = "Shrimp"
        case squid = "Squid"
    }
}
