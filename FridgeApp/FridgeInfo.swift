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
    

    struct PropertyKey {
        
        static let fridgeNameKey = "fridgeName"
        static let numKey = "numOfDoors"
        static let doorNameKey = "doorNames"
        
    }
    
    override init() {
        self.fridgeName = "Add a Fridge"
        self.numOfDoors = 0
        self.doorNames = ["Blank"]
    }
    
    init?(fridgeName: String, numOfDoors: Int, doorNames: Array<String>) {

        self.fridgeName = fridgeName
        self.numOfDoors = numOfDoors
        self.doorNames = doorNames
        
        super.init()
        
    }

    // MARK: NSCoding
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(fridgeName, forKey: PropertyKey.fridgeNameKey)
        aCoder.encodeObject(numOfDoors, forKey: PropertyKey.numKey)
        aCoder.encodeObject(doorNames, forKey: PropertyKey.doorNameKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let fridgeName = aDecoder.decodeObjectForKey(PropertyKey.fridgeNameKey) as! String
        
        let numOfDoors = aDecoder.decodeObjectForKey(PropertyKey.numKey) as! Int
        
        let doorNames = aDecoder.decodeObjectForKey(PropertyKey.doorNameKey) as! Array<String>
        
        // Must call designated initializer.
        self.init(fridgeName: fridgeName, numOfDoors: numOfDoors, doorNames: doorNames)
        
    }
    
    // MARK: Archiving Paths
    
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("fridge")
    
}