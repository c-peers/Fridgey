//
//  ListDetailsViewController.swift
//  FridgeApp
//
//  Created by Chase Peers on 12/21/15.
//  Copyright © 2015 Chase Peers. All rights reserved.
//

import UIKit

class ListDetailsViewController: UIViewController {

    @IBOutlet weak var tempListView: UITextView!
    
    var listName: String?
    var listDetails: [Int:String]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print(listName)
        print(listDetails)
        
        var tempList: [String] = []
        
        if listDetails != nil {
            
        for dictCounter in 1...listDetails!.count {
            tempList.append(listDetails![dictCounter]!)
        }

        }
            
        print(tempList)
        
        //tempListView.text = tempList
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func cancelAction(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
        
    
}
