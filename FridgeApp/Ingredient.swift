//
//  Ingredient.swift
//  FridgeApp
//
//  Created by Chase Peers on 9/28/15.
//  Copyright © 2015 Chase Peers. All rights reserved.
//

import Foundation
import UIKit

class Ingredient: NSObject, NSCoding {
    // MARK: Properties
    
    var name: String
    var image:  UIImage?
    var expiry: String
    var amount: Float
    var location: String
    //var addedDate: String
    
    // MARK: Types
    
    struct PropertyKey {
        
        static let nameKey = "name"
        static let imageKey = "image"
        static let expiryKey = "expiry"
        static let amountKey = "amount"
        static let locationKey = "location"
        
    }

    override init() {
        self.name = "none"
        self.image = nil
        self.expiry = "none"
        self.amount = 0.0
        self.location = "none"
    }
    
    
    init?(name: String, image: UIImage?, expiry: String, amount: Float, location: String) {
        self.name = name
        self.image = image
        self.expiry = expiry
        self.amount = amount
        self.location = location
        //self.addedDate = addedDate
        
        super.init()
        
        //if name.isEmpty || expiry.isEmpty {
        //     return nil
        //}
                
    }
    
    // MARK: NSCoding
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: PropertyKey.nameKey)
        aCoder.encodeObject(image, forKey: PropertyKey.imageKey)
        aCoder.encodeObject(expiry, forKey: PropertyKey.expiryKey)
        aCoder.encodeObject(amount, forKey: PropertyKey.amountKey)
        aCoder.encodeObject(location, forKey: PropertyKey.locationKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObjectForKey(PropertyKey.nameKey) as! String
        
        // Because photo is an optional property of Meal, use conditional cast.
        let image = aDecoder.decodeObjectForKey(PropertyKey.imageKey) as? UIImage
        
        let expiry = aDecoder.decodeObjectForKey(PropertyKey.expiryKey) as! String
        
        let amount = aDecoder.decodeObjectForKey(PropertyKey.amountKey) as! Float

        let location = aDecoder.decodeObjectForKey(PropertyKey.locationKey) as! String
        
        // Must call designated initializer.
        self.init(name: name, image: image, expiry: expiry, amount: amount, location: location)
        
    }
    
    // MARK: Archiving Paths
    
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("ingredients")

    
}

