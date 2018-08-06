//
//  Helpers.swift
//  SpyMe
//
//  Created by Danny Navarro on 6/16/18.
//  Copyright © 2018 Danny Navarro. All rights reserved.
//

import UIKit

func log(_ statement:Any) {
    print(statement)
}

func TopController() -> UIViewController {
    var topController : UIViewController = (UIApplication.shared.keyWindow?.rootViewController)!
    
    while (topController.presentedViewController != nil) {
        topController = topController.presentedViewController!
    }
    return topController
}

func randomString(length: Int) -> String {
    let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    let len = UInt32(letters.length)
    
    var randomString = ""
    
    for _ in 0 ..< length {
        let rand = arc4random_uniform(len)
        var nextChar = letters.character(at: Int(rand))
        randomString += NSString(characters: &nextChar, length: 1) as String
    }
    
    return randomString
}

func checkText(text:String) -> Bool
{
    let whitespace = NSCharacterSet.whitespaces
    
    let range = text.rangeOfCharacter(from: whitespace)
    
    // range will be nil if no whitespace is found
    if range != nil || text.isEmpty {
        return false
    } else {
        return true
    }
}
