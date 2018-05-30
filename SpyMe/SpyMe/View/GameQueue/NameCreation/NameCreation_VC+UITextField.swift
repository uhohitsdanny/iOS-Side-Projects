//
//  NameCreation_VC+UITextField.swift
//  SpyMe
//
//  Created by Danny Navarro on 5/30/18.
//  Copyright © 2018 Danny Navarro. All rights reserved.
//

import Foundation
import UIKit

extension NameCreation_VC: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        let name = textField.text
        if name!.count > MAX_CHARACTERS{
            maxCharsLabel?.isHidden = false
        }else{
            maxCharsLabel?.isHidden = true
        }
    }
}
