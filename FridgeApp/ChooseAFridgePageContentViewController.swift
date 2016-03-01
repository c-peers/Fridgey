//
//  ChooseAFridgePageContentViewController.swift
//  FridgeApp
//
//  Created by Chase Peers on 2/29/16.
//  Copyright © 2016 Chase Peers. All rights reserved.
//

import UIKit

class ChooseAFridgePageContentViewController: UIViewController {
    
    @IBOutlet weak var fridgeImageView: UIImageView!
    
    var dataObject: AnyObject?
    
    var pageIndex: Int!
    var fridgeIndex: String!
    var FridgeImage: String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.fridgeImageView.image = UIImage(named: self.FridgeImage)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
