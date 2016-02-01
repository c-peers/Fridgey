//
//  ListCollectionViewCell.swift
//  FridgeApp
//
//  Created by Chase Peers on 12/21/15.
//  Copyright © 2015 Chase Peers. All rights reserved.
//

import UIKit

class ListCollectionViewCell: UICollectionViewCell, UITextFieldDelegate {
    
    @IBOutlet weak var listName: UILabel!
    @IBOutlet weak var nameNewListText: UITextField!
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true;
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        
    }

}
