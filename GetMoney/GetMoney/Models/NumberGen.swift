//
//  NumberGenerator.swift
//  GetMoney
//
//  Created by Danny Navarro on 4/13/19.
//  Copyright © 2019 Squirrel. All rights reserved.
//

import Foundation

var MAXLINES = 5

class NumberGen
{
    var numbers : [[Int]]
    
    init()
    {
        numbers = []
    }
    
}

extension NumberGen
{
    func generate()
    {
        for i in 1...MAXLINES
        {
            numbers.append(Array.init())
            numbers[i-1].append(Int.random(in: 1..<47))
            numbers[i-1].append(Int.random(in: 1..<47))
            numbers[i-1].append(Int.random(in: 1..<47))
            numbers[i-1].append(Int.random(in: 1..<47))
            numbers[i-1].append(Int.random(in: 1..<47))
            numbers[i-1].append(Int.random(in: 1..<27))
        }
    }
    
    func get(line number:Int)
    {
        
    }
}
