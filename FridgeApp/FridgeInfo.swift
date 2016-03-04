//
//  FridgeInfo.swift
//  FridgeApp
//
//  Created by Chase Peers on 9/22/15.
//  Copyright © 2015 Chase Peers. All rights reserved.
//

import Foundation

class FridgeInfo : NSObject, NSCoding {

    // MARK: Properties
    var fridgeName: String
    var numOfDoors: Int
    var doorNames: Array<String>
    var fridgeImage: String
    

    struct PropertyKey {
        
        static let fridgeNameKey = "fridgeName"
        static let numKey = "numOfDoors"
        static let doorNameKey = "doorNames"
        static let fridgeImageKey = "fridgeImage"
        
    }
    
    override init() {
        self.fridgeName = "Add a Fridge"
        self.numOfDoors = 0
        self.doorNames = ["Blank"]
        self.fridgeImage = "Blank"
    }
    
    init?(fridgeName: String, numOfDoors: Int, doorNames: Array<String>, fridgeImage: String) {

        self.fridgeName = fridgeName
        self.numOfDoors = numOfDoors
        self.doorNames = doorNames
        self.fridgeImage = fridgeImage
        
        super.init()
        
    }

    // MARK: NSCoding
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(fridgeName, forKey: PropertyKey.fridgeNameKey)
        aCoder.encodeObject(numOfDoors, forKey: PropertyKey.numKey)
        aCoder.encodeObject(doorNames, forKey: PropertyKey.doorNameKey)
        aCoder.encodeObject(fridgeImage, forKey: PropertyKey.fridgeImageKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let fridgeName = aDecoder.decodeObjectForKey(PropertyKey.fridgeNameKey) as! String
        
        let numOfDoors = aDecoder.decodeObjectForKey(PropertyKey.numKey) as! Int
        
        let doorNames = aDecoder.decodeObjectForKey(PropertyKey.doorNameKey) as! Array<String>

        let fridgeImage = aDecoder.decodeObjectForKey(PropertyKey.fridgeImageKey) as! String
        
        // Must call designated initializer.
        self.init(fridgeName: fridgeName, numOfDoors: numOfDoors, doorNames: doorNames, fridgeImage: fridgeImage)
        
    }
    
    // MARK: Archiving Paths
    
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("fridge")
    
}