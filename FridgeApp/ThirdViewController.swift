//
//  ThirdViewController.swift
//  FridgeApp
//
//  Created by Chase Peers on 9/5/15.
//  Copyright (c) 2015 Chase Peers. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController, TabBarDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func didSelectTab(tabBarController: FridgeTabBarController) {
        print("thirst!")
    }
    
    override func viewWillAppear(animated: Bool) {
        print("vwa")
    }
}
