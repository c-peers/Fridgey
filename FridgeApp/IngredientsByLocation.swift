//
//  IngredientsByLocation.swift
//  FridgeApp
//
//  Created by Chase Peers on 11/29/15.
//  Copyright © 2015 Chase Peers. All rights reserved.
//

import Foundation
import UIKit

class IngredientsByLocation: NSObject, NSCoding {
    // MARK: Properties
    
    var IBLArray: [[String]] = []
    
    // MARK: Types
    
    struct PropertyKey {
        
        static let IBLArrayKey = "IBLArray"
        
    }
    
    override init() {
        self.IBLArray = []
    }
    
    init(savedIBLArray: [[String]]) {
        
        IBLArray = savedIBLArray
     
        print(IBLArray)
    }
    
    init?(Location: [String], Ingredients: [Ingredient]) {
        
        print("location")
        print(Location)
        
        for x in 0...Location.count - 1 {

            var arrayYValue = 0
            var tempArray: [String] = []
            
            print("x")
            print(x)

            for y in 0...Ingredients.count - 1 {
                
                print("y")
                print(y)
                
                print("location")
                print(Location[x])
                
                print("Ingredient.location")
                print(Ingredients[y].location)
                
                if Location[x] == Ingredients[y].location {
                    
                        tempArray.append(Ingredients[y].location)
                        //IBLArray[x].append(Ingredients[y].location)
                        arrayYValue += 1
                    
                } else {
                    print("no match")
                }
                
            }
        
            //if IBLArray[x].count < 1 {
            //    IBLArray.append(["blank"])
            //}
            
            print("temp")
            print(tempArray)
            print(tempArray.count)
            
            if tempArray.count == 0 {
                IBLArray.append(["Empty"])
            } else {
                
                IBLArray.append(tempArray)
                
            }
            
            print("IBLArray")
            print(IBLArray)
            
        }

        print(IBLArray)
        
        super.init()
        
    }
    
    // MARK: NSCoding
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(IBLArray, forKey: PropertyKey.IBLArrayKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let IBLArray = aDecoder.decodeObjectForKey(PropertyKey.IBLArrayKey) as! [[String]]
        
        // Must call designated initializer.
        self.init(savedIBLArray: IBLArray)
        
    }
    
    // MARK: Archiving Paths
    
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("IngredientsByLocation")
    
    
}

