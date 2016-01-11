//
//  PersistenceHandler.swift
//  FridgeApp
//
//  Created by Chase Peers on 1/8/16.
//  Copyright © 2016 Chase Peers. All rights reserved.
//

import Foundation

class PersistenceHandler {

    func load(loadVar: String) -> Bool {
        
        switch loadVar {
            case "All":
            
                fallthrough
        
            case "Fridge":
                
                if let savedFridge = loadFridge() {
                    
                    PersistManager.sharedManager.MyFridge = savedFridge
                    print(savedFridge)
                    
                    print("Saved Fridge")
                    print(PersistManager.sharedManager.MyFridge.numOfDoors)
                    print(PersistManager.sharedManager.MyFridge.doorNames)
                    print(PersistManager.sharedManager.MyFridge.fridgeName)
                    
                    if loadVar == "All" {
                        fallthrough
                    } else {
                        return true
                    }
                    
                } else {
                    
                    // No fridge, set defaults... for now.
                    PersistManager.sharedManager.MyFridge = FridgeInfo(fridgeName: "Fridge", numOfDoors: 2, doorNames: ["1", "2"])!
                    return false
            }

            case "Ingredients":
            
                if let savedIngredients = loadIngredients() {
                    
                    PersistManager.sharedManager.Ingredients = savedIngredients
                    print(savedIngredients)
                    
                    print("Saved Ingredients")
                    print(PersistManager.sharedManager.Ingredients)
                    
                    if loadVar == "All" {
                        fallthrough
                    } else {
                        return true
                    }
                    
                } else {
                    sampleIngredients()
                    return false
            }

            case "Lists":
            
                if let savedList = loadList() {
                    
                    PersistManager.sharedManager.ShoppingLists = savedList
                    print(savedList)
                    
                    print("Saved List")
                    print(PersistManager.sharedManager.ShoppingLists.lists)
                    
                    return true
                    
                } else {
                
                    sampleLists()
                    return false
                }
            
            default:
                return false
            
        }
        
    }
    
    func save() {
        
        saveFridge()
        
        saveIngredients()
        
        saveList()
        
    }
  
    private func saveFridge() {
        
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(PersistManager.sharedManager.MyFridge, toFile: FridgeInfo.ArchiveURL.path!)
        
        print("Fridge saved?")
        
        if !isSuccessfulSave {
            print("Couldn't save")
        }
        
    }
    
    private func loadFridge() -> FridgeInfo? {
        print("Fridge loaded")
        print(FridgeInfo.ArchiveURL.path!)
        
        return NSKeyedUnarchiver.unarchiveObjectWithFile(FridgeInfo.ArchiveURL.path!) as? FridgeInfo
        
    }
    
    private func saveIngredients() {
        
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(PersistManager.sharedManager.Ingredients, toFile: Ingredient.ArchiveURL.path!)
        print("Ingredients saved?")
        
        if !isSuccessfulSave {
            print("Couldn't save")
        }
        
    }
    
    private func loadIngredients() -> [[Ingredient]]? {
        print("Ingredients loaded")
        print(Ingredient.ArchiveURL.path!)
        return NSKeyedUnarchiver.unarchiveObjectWithFile(Ingredient.ArchiveURL.path!) as? [[Ingredient]]
        
    }
    
    private func saveList() {
        
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(PersistManager.sharedManager.ShoppingLists, toFile: Lists.ArchiveURL.path!)
        print("Lists saved?")
        
        if !isSuccessfulSave {
            print("Couldn't save")
        }
        
    }
    
    private func loadList() -> Lists? {
        print("Lists loaded")
        print(Lists.ArchiveURL.path!)
        
        return NSKeyedUnarchiver.unarchiveObjectWithFile(Lists.ArchiveURL.path!) as? Lists
        
    }

    // Temporary Sample
    func sampleIngredients() {
        
        let ingredient1 = [Ingredient(name: "Carrot", image: UIImage(named: "blank"), expiry: "2015-10-4", amount: 400.0, location: "Area 1 Door")!]
        PersistManager.sharedManager.Ingredients.append(ingredient1)
        
        let ingredient2 = [Ingredient(name: "Eggs", image: UIImage(named: "blank"), expiry: "2015-10-2", amount: 6.0, location: "Area 2 Door")!]
        PersistManager.sharedManager.Ingredients.append(ingredient2)
        
        let ingredient3 = [Ingredient(name: "Ice Cream", image: UIImage(named: "blank"), expiry: "2016-4-29", amount: 10.0, location: "Area 3 Door")!]
        PersistManager.sharedManager.Ingredients.append(ingredient3)
        
        let ingredient4 = [Ingredient(name: "Potato", image: UIImage(named: "blank"), expiry: "2015-10-8", amount: 850.0, location: "Area 4 Door")!]
        PersistManager.sharedManager.Ingredients.append(ingredient4)
        
        
    }
    
    // Temporary Sample
    func sampleLists() {
        
        //let list1Dic = ["Super1 List" : [1:"Carrots", 2:"Brocolli"]]
        let list1Dic = [1:"Carrots", 2:"Brocolli"]
        //let list1 = Lists.addList("Super 1 List", list1Dic)
        PersistManager.sharedManager.ShoppingLists.addList("Super 1 List", listDetail: list1Dic)
        //let list1 = Lists(listName: "Super 1 List", listDetail: list1Dic)
        
        //let list2Dic = ["Super 2 List" : [1:"Potatoes", 2:"Milk", 3:"Eggs"]]
        let list2Dic = [1:"Potatoes", 2:"Milk", 3:"Eggs"]
        PersistManager.sharedManager.ShoppingLists.addList("Super 2 List", listDetail: list2Dic)
        //let list2 = Lists(lists: list2Dic)!
        
        //let list3Dic = ["Super 3 List" : [1:"Juice", 2: "Pop"]]
        let list3Dic = [1:"Juice", 2: "Pop"]
        PersistManager.sharedManager.ShoppingLists.addList("Super 3 List", listDetail: list3Dic)
        //let list3 = Lists(lists: list3Dic)
        
    }

    
}