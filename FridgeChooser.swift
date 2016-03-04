//
//  FridgeChooser.swift
//  FridgeApp
//
//  Created by Chase Peers on 3/3/16.
//  Copyright © 2016 Chase Peers. All rights reserved.
//

import Foundation

class FridgeChooser {
    
    let fridgeImageList = ["2_door_mini", "2_door", "3_door", "4_door", "4_door-2", "5_door", "6_door", "6_door-2", "french_door", "side_by_side"]
    let fridgeDict = ["2_door_mini": 2, "2_door": 2, "3_door": 3, "4_door": 4, "4_door-2": 4, "5_door": 5, "6_door": 6 , "6_door-2": 6, "french_door": 2, "side_by_side": 2]

    var imageIndex: Int
    
    init() {
        self.imageIndex = 0
    }
    
}