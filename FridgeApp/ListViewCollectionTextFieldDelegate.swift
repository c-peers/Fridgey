//
//  ListViewCollectionTextFieldDelegate.swift
//  FridgeApp
//
//  Created by Chase Peers on 1/31/16.
//  Copyright © 2016 Chase Peers. All rights reserved.
//

import Foundation

class ListViewCollectionTextFieldDelegate: NSObject, UITextFieldDelegate {

    /**
     * Examines the new string whenever the text changes. Finds color-words, blends them, and set the text color
     */
    
//    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
//        
//        var newText: NSString
//        
//        // Construct the text that will be in the field if this change is accepted
//        newText = textField.text!
//        print(newText)
//        newText = newText.stringByReplacingCharactersInRange(range, withString: string)
//        print(newText)
//        // For each dictionary entry in translations, pull out a string to search for
//        
//        
//        return true
//    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true;
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        
    }
        
}
