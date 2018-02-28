//
//  TextFieldCell.swift
//  Easy Decision
//
//  Created by Danny Navarro on 2/19/18.
//

import Foundation
import UIKit

class TextInputCell: UITableViewCell {
    
    @IBOutlet weak var textField: UITextField!
    
    public func configure(text: String?, placeholder: String) {
        textField.text = text
        textField.placeholder = placeholder
        
        textField.accessibilityValue = text
        textField.accessibilityLabel = placeholder
    }
    
}
