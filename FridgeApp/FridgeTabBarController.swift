//
//  FridgeTabBarController.swift
//  FridgeApp
//
//  Created by Chase Peers on 11/22/15.
//  Copyright © 2015 Chase Peers. All rights reserved.
//

import UIKit

class FridgeTabBarController: UITabBarController, UITabBarControllerDelegate {

    //These classes are now viewable by all tabs
    var MyFridge = FridgeInfo()
    
    var Ingredients = [[Ingredient]]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tabBarController(tabBarController: UITabBarController, didSelectViewController viewController: UIViewController) {
        if viewController is TabBarDelegate {
            let v = viewController as! TabBarDelegate
            v.didSelectTab(self)
        }
    }
    
}
