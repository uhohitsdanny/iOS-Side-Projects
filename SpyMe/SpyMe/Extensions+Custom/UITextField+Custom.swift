//
//  UITextField+Custom.swift
//  SpyMe
//
//  Created by Danny Navarro on 5/25/18.
//  Copyright © 2018 Danny Navarro. All rights reserved.
//

import UIKit

class TextFieldCustom: UITextField {
    override func caretRect(for position: UITextPosition) -> CGRect {
        var rect = super.caretRect(for: position)
        
        // Custom cursor size
        rect.size.height = (super.font?.pointSize)! - 5
        // Readjusts cursor to center
        rect.origin.y = (super.font?.pointSize)! - rect.size.height

        return rect
    }
    
    
}
