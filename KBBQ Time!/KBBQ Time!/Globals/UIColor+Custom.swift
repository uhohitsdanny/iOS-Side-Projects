//
//  UIColor+Custom.swift
//  KBBQ Time!
//
//  Created by Danny Navarro on 12/15/18.
//  Copyright © 2018 Squirrel. All rights reserved.
//

import UIKit

extension UIColor
{
    struct kbbq
    {
        static var primary : UIColor
        {
            return UIColor(rgb: 0xEAD6CD, a: 1.0)
        }
        
        static var secondary : UIColor
        {
            return UIColor(rgb: 0xEDC7B7, a: 1.0)
        }
        
        static var tetriary : UIColor
        {
            return UIColor(rgb: 0xAC3B61, a: 1.0)
        }
    }
    
    convenience init(red: Int, green: Int, blue: Int)
    {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(red: Int, green: Int, blue: Int, a: CGFloat = 1.0)
    {
        self.init(
            red: CGFloat(red) / 255.0,
            green: CGFloat(green) / 255.0,
            blue: CGFloat(blue) / 255.0,
            alpha: a
        )
    }
    
    convenience init(rgb: Int, a: CGFloat = 1.0)
    {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF,
            a: a
        )
    }
}

