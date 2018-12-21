//
//  Designables.swift
//  StockMarket
//
//  Created by Danny Navarro on 12/4/18.
//  Copyright © 2018 Daramji. All rights reserved.
//

import UIKit

// Designables
@IBDesignable
class DesignableView: UIView {}

@IBDesignable
class DesignableButton: UIButton {}

@IBDesignable
class DesignableLabel: UILabel {}


@IBDesignable
class DesignableImageView: UIImageView {}


@IBDesignable
class DesignableTextView: UITextView {}

@IBDesignable
class DesignableTextField: UITextField {}



// Designable Exts
@IBDesignable extension UIView
{
    @IBInspectable var borderColor: UIColor?
    {
        set
        {
            layer.borderColor = newValue?.cgColor
        }
        get
        {
            guard let color = layer.borderColor else
            {
                return nil
            }
            return UIColor(cgColor: color)
        }
    }
    
    @IBInspectable var borderWidth: CGFloat
    {
        set
        {
            layer.borderWidth = newValue
        }
        get
        {
            return layer.borderWidth
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat
    {
        set
        {
            layer.cornerRadius = newValue
            clipsToBounds = newValue > 0
        }
        get
        {
            return layer.cornerRadius
        }
    }
}
