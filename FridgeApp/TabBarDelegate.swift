//
//  TabBarDelegate.swift
//  FridgeApp
//
//  Created by Chase Peers on 12/14/15.
//  Copyright © 2015 Chase Peers. All rights reserved.
//

import Foundation

@objc protocol TabBarDelegate {
    
    func didSelectTab(tabBarController: FridgeTabBarController)
}