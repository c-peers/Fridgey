//
//  FridgeTabBarController.swift
//  FridgeApp
//
//  Created by Chase Peers on 11/22/15.
//  Copyright © 2015 Chase Peers. All rights reserved.
//

import UIKit

class FridgeTabBarController: UITabBarController, UITabBarControllerDelegate {

    @IBOutlet weak var fridgeTabBar: UITabBar!
    
    //These classes are now viewable by all tabs
    var MyFridge = FridgeInfo()
    
    var Ingredients = [[Ingredient]]()
    
    var ShoppingLists = Lists()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tabBarController(tabBarController: UITabBarController, didSelectViewController viewController: UIViewController) {
        if viewController is TabBarDelegate {
            let v = viewController as! TabBarDelegate
            v.didSelectTab(self)
        }
        
        if viewController.editing {
            print("is run?")
            fridgeTabBar.hidden = true
            self.tabBar.hidden = true
        } else {
            fridgeTabBar.hidden = false
            self.tabBar.hidden = false
        }
        
    }
    
}
