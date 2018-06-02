//
//  NameCreation+UITextField.swift
//  SpyMe
//
//  Created by Danny Navarro on 6/2/18.
//  Copyright © 2018 Danny Navarro. All rights reserved.
//

import UIKit

extension NameCreation_VC: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentString: NSString = textField.text! as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= CHARACTER_LIMIT
    }
}
