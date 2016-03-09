//
//  FinishedShopping.swift
//  FridgeApp
//
//  Created by Chase Peers on 1/20/16.
//  Copyright © 2016 Chase Peers. All rights reserved.
//

import UIKit

class FinishedShoppingViewController: UIViewController {

    var selectedFromList: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Make it look like the view is on top of the previous view
        //view.backgroundColor = UIColor.whiteColor()
        
        self.view.backgroundColor = UIColor(white: 0, alpha: 0.4)
        
        // Round corners and shadows
        backgroundView.layer.cornerRadius = 8
        
        backgroundView.layer.masksToBounds = true
        
        backgroundView.layer.borderColor = UIColor.grayColor().CGColor
        backgroundView.layer.borderWidth = 0.5
        
        backgroundView.layer.shadowColor = UIColor.blackColor().CGColor
        backgroundView.layer.shadowOffset = CGSizeZero
        backgroundView.layer.shadowRadius = 5.0
        backgroundView.layer.shadowOpacity = 0.5
        backgroundView.layer.masksToBounds = false
        backgroundView.clipsToBounds = false

        
        var ingredients = PersistManager.sharedManager.Ingredients
        var ingredientsToBeAdded = [Ingredient]()
        
        for ingredient in 0...selectedFromList.count - 1 {
            let addIngredient = [Ingredient(name: selectedFromList[ingredient], image: nil, expiry: "", amount: 0.0, location: "Area 1 Door")!]
            ingredientsToBeAdded += addIngredient
        }
        
        if ingredientsToBeAdded.count > 0 {
            ingredients[0] += ingredientsToBeAdded
        }
        
        PersistManager.sharedManager.Ingredients = ingredients
        let saveList = PersistenceHandler()
        saveList.save()
        
        
        
    }
    
    @IBAction func cancel(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
}
