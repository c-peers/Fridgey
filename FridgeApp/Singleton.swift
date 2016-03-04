//
//  Singleton.swift
//  FridgeApp
//
//  Created by Chase Peers on 1/4/16.
//  Copyright © 2016 Chase Peers. All rights reserved.
//

import Foundation

class PersistManager: NSObject {
    
    // These are the properties you can store in your singleton
    var MyFridge = FridgeInfo()
    var Ingredients = [[Ingredient]]()
    var ShoppingLists = Lists()
    var fridgeChooser = FridgeChooser()
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
    
    func initialLoading() {
        //MyFridge = self.loadFridge()!
        //Ingredients = self.loadIngredients()!
        //ShoppingLists = self.loadList()!
        
    }
    
    // MARK: NSCoding
//    func save() {
//        let path = documentsDirectory()
//        print("save: \(path)")
//        // Each Stuff object conforms to NSCoding, so can be archived
//        // using NSKeyedArchiver
//        NSKeyedArchiver.archiveRootObject(self.MyFridge, toFile: path)
//        NSKeyedArchiver.archiveRootObject(self.Ingredients, toFile: path)
//        NSKeyedArchiver.archiveRootObject(self.ShoppingLists, toFile: path)
//    }
    
    func encode() {
        print(PersistManager.path())
        let dbPath = NSURL(fileURLWithPath: PersistManager.path()).URLByAppendingPathComponent("Fridge")
        NSKeyedArchiver.archiveRootObject(MyFridge, toFile: dbPath.path!)
    }
    
    func decode() -> FridgeInfo? {
        print(PersistManager.path())
        let dbPath = NSURL(fileURLWithPath: PersistManager.path()).URLByAppendingPathComponent("Fridge")

        let decodedObject = NSKeyedUnarchiver.unarchiveObjectWithFile(dbPath.path!) as? FridgeInfo
        
        return decodedObject
    }
    
    class func path() -> String {
        let documentsFolder = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0] as String
        let path = documentsFolder
        //let documentsPath = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true).first
        //let path = documentsPath?.stringByAppendingString("/DB")
        return path
    }
    
    func saveFridge() {
        
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(MyFridge, toFile: FridgeInfo.ArchiveURL.path!)
        
        print("Fridge saved?")
        
        if !isSuccessfulSave {
            print("Couldn't save")
        }
        
    }
    
    func loadFridge() -> FridgeInfo? {
        print("Fridge loaded")
        print(FridgeInfo.ArchiveURL.path!)
        
        return NSKeyedUnarchiver.unarchiveObjectWithFile(FridgeInfo.ArchiveURL.path!) as? FridgeInfo
        
    }

    func saveIngredients() {
        
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(Ingredients, toFile: Ingredient.ArchiveURL.path!)
        print("Ingredients saved?")

        if !isSuccessfulSave {
            print("Couldn't save")
        }
        
    }
    
    func loadIngredients() -> [[Ingredient]]? {
        print("Ingredients loaded")
        print(Ingredient.ArchiveURL.path!)
        return NSKeyedUnarchiver.unarchiveObjectWithFile(Ingredient.ArchiveURL.path!) as? [[Ingredient]]
        
    }

    func saveList() {
        
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(ShoppingLists, toFile: Lists.ArchiveURL.path!)
        print("Lists saved?")
        
        if !isSuccessfulSave {
            print("Couldn't save")
        }
        
    }
    
    func loadList() -> Lists? {
        print("Lists loaded")
        print(Lists.ArchiveURL.path!)
        
        return NSKeyedUnarchiver.unarchiveObjectWithFile(Lists.ArchiveURL.path!) as? Lists
        
    }

    
}
