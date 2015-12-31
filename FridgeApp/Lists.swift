//
//  Lists.swift
//  FridgeApp
//
//  Created by Chase Peers on 12/27/15.
//  Copyright © 2015 Chase Peers. All rights reserved.
//

class Lists : NSObject, NSCoding {
    
    // MARK: Properties
    var lists: [String:[Int:String]]
    var listName: String
    var listDetail: [Int:String]
    
    struct PropertyKey {
        
        static let listsKey = "listsKey"
        //static let listNameKey = "listName"
        //static let listDetailKey = "listDetailKey"
        
    }
    
    override init() {
        self.listName = ""
        self.listDetail = [:]
        self.lists = ["":[1:""]]
    }
    
    func addList(listName: String, listDetail: [Int:String]) {
        lists[listName] = listDetail
    }
    
//    init?(listName: String, listDetail: [Int:String]) {
//        
//        self.listName = listName
//        self.listDetail = listDetail
//        
//        //lists[listName] = listDetail
//        //lists.updateValue(listDetail, forKey: listName)
//        
//        super.init()
//        
//    }
    
    init(lists: [String:[Int:String]]) {
        
        self.lists = lists
        self.listName = ""
        self.listDetail = [:]
        
        super.init()
    }
    
    // MARK: NSCoding
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(lists, forKey: PropertyKey.listsKey)
        //aCoder.encodeObject(listName, forKey: PropertyKey.listNameKey)
        //aCoder.encodeObject(listDetail, forKey: PropertyKey.listDetailKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let lists = aDecoder.decodeObjectForKey(PropertyKey.listsKey) as! [String:[Int:String]]
        //let listName = aDecoder.decodeObjectForKey(PropertyKey.listNameKey) as! String
        //let listDetail = aDecoder.decodeObjectForKey(PropertyKey.listDetailKey) as! [Int:String]
        
        // Must call designated initializer.
        //self.init(listName: listName, listDetail: listDetail)
        self.init(lists: lists)
        
    }
    
    // MARK: Archiving Paths
    
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("list")
    
}