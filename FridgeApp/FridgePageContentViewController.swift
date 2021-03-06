//
//  FridgePageContentViewController.swift
//  FridgeApp
//
//  Created by Chase Peers on 11/7/15.
//  Copyright © 2015 Chase Peers. All rights reserved.
//

import UIKit

class FridgePageContentViewController: UIViewController {

    @IBOutlet weak var fridgeImageView: UIImageView!
    @IBOutlet weak var fridgeTitle: UILabel!
    
    
    var dataObject: AnyObject?
    
    var pageIndex: Int!
    var fridgeIndex: String!
    var FridgeImage: String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.fridgeImageView.image = UIImage(named: self.FridgeImage)
        self.fridgeTitle.text = self.fridgeIndex
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
