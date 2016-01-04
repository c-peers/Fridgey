//
//  PeristenceManager.swift
//  FridgeApp
//
//  Created by Chase Peers on 1/4/16.
//  Copyright © 2016 Chase Peers. All rights reserved.
//

import Foundation

class PersistManager {
    
    // These are the properties you can store in your singleton
    var MyFridge = FridgeInfo()
    var Ingredients = [[Ingredient]]()
    var ShoppingLists = Lists()
    var Test = "Test"
    
    // Here is how you would get to it without there being a global collision of variables.
    // , or in other words, it is a globally accessable parameter that is specific to the
    // class.
    class var sharedManager: PersistManager {
        struct Static {
            static let instance = PersistManager()
        }
        return Static.instance
    }
    
    // MARK: NSCoding
    func saveFridge() {
        
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(MyFridge, toFile: FridgeInfo.ArchiveURL.path!)
        
        if !isSuccessfulSave {
            print("Couldn't save")
        }
        
    }
    
    func loadFridge() -> FridgeInfo? {
        
        return NSKeyedUnarchiver.unarchiveObjectWithFile(FridgeInfo.ArchiveURL.path!) as? FridgeInfo
        
    }

    func saveIngredients() {
        
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(Ingredients, toFile: Ingredient.ArchiveURL.path!)
        
        if !isSuccessfulSave {
            print("Couldn't save")
        }
        
    }
    
    func loadIngredients() -> [[Ingredient]]? {
        
        return NSKeyedUnarchiver.unarchiveObjectWithFile(Ingredient.ArchiveURL.path!) as? [[Ingredient]]
        
    }

    func saveList() {
        
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(ShoppingLists, toFile: Lists.ArchiveURL.path!)
                
        if !isSuccessfulSave {
            print("Couldn't save")
        }
        
    }
    
    func loadList() -> Lists? {
        
        return NSKeyedUnarchiver.unarchiveObjectWithFile(Lists.ArchiveURL.path!) as? Lists
        
    }

    
}