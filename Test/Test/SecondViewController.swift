//
//  SecondViewController.swift
//  Test
//
//  Created by Chase Peers on 12/15/15.
//  Copyright © 2015 Chase Peers. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, TabBarDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func didSelectTab(tabBarController: TabBarController) {
        print("secfirst!")
    }
}

