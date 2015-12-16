//
//  IngredientNavigationController.swift
//  FridgeApp
//
//  Created by Chase Peers on 12/15/15.
//  Copyright © 2015 Chase Peers. All rights reserved.
//

import Foundation
import UIKit

class IngredientNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        let IngredientTable = FoodsListTableViewController()
        NSNotificationCenter.defaultCenter().postNotificationName("load", object: nil)
        print("Table view did appear")
    }
    
    
}
