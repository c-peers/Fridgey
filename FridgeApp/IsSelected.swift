//
//  IsSelected.swift
//  FridgeApp
//
//  Created by Chase Peers on 1/15/16.
//  Copyright © 2016 Chase Peers. All rights reserved.
//

import UIKit

class IsSelected: UIButton {

    // MARK: Properties
    
    var isTapped = false
    var selectedButton = UIButton()
    var selectedIngredients = []
    
    // MARK: Initialization
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        let emptyCircle = UIImage(named: "Unselected")
        let filledCircle = UIImage(named: "Selected")
        
        //let button = UIButton()
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        button.setImage(emptyCircle, forState: .Normal)
        button.setImage(filledCircle, forState: .Selected)
        button.setImage(filledCircle, forState: [.Highlighted,.Selected])
        //button.backgroundColor = UIColor.redColor()
        button.adjustsImageWhenHighlighted = false
        //button.addTarget(self, action: "buttonWasTapped:", forControlEvents: .TouchDown)
        addSubview(button)
        
    }
    
    override func intrinsicContentSize() -> CGSize {
        let buttonSize = Int(frame.size.height)
        
        return CGSize(width: buttonSize, height: buttonSize)
    }
    
    override func layoutSubviews() {
        let buttonSize = Int(frame.size.height)
        let buttonFrame = CGRect(x: 0, y: 0, width: buttonSize, height: buttonSize)
        
        //updateButtonSelectedState()
    }
    
    func buttonWasTapped(sender: UIButton) {
        print("OK")
        if sender.selected == true {
            sender.selected = false
        } else {
            sender.selected = true
        }
        //updateButtonSelectedState()
        
    }
    
    func updateButtonSelectedState() {
        
        
    }
    
}
