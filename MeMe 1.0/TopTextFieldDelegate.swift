//
//  TopTextFieldDelegate.swift
//  MeMe 1.0
//
//  Created by owner on 24/05/2021.
//

import Foundation
import UIKit


class TopTextFieldDelegate: NSObject, UITextFieldDelegate{    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
