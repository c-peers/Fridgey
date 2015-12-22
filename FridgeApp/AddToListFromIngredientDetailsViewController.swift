//
//  AddToListFromIngredientDetailsViewController.swift
//  FridgeApp
//
//  Created by Chase Peers on 12/21/15.
//  Copyright © 2015 Chase Peers. All rights reserved.
//

import UIKit

class AddToListFromIngredientDetailsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.view.backgroundColor = UIColor(white: 0, alpha: 0.4)
        
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
    @IBAction func cancelAddToList(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
    }

}
