//
//  UIImageView+Custom.swift
//  KBBQ Time!
//
//  Created by Danny Navarro on 12/17/18.
//  Copyright © 2018 Squirrel. All rights reserved.
//

import UIKit.UIImageView

extension UIImageView
{
    override open func layoutSubviews()
    {
        super.layoutSubviews()
        let radius : CGFloat = self.bounds.size.width / 2.0
        self.layer.cornerRadius = radius
    }
}
