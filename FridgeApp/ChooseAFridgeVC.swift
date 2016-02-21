//
//  ChooseAFridge.swift
//  FridgeApp
//
//  Created by Chase Peers on 9/20/15.
//  Copyright © 2015 Chase Peers. All rights reserved.
//

import UIKit

class ChooseAFridgeViewController: UIViewController {
    
    var fridgeInfo: FridgeInfo?
    
    @IBOutlet weak var refridgeratorCompartments: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        stepper.wraps = true
        stepper.autorepeat = true
        stepper.maximumValue = 7
        stepper.minimumValue = 1
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func changeFridgeDoorNum(sender: UIStepper) {
        refridgeratorCompartments.text = Int(sender.value).description
        
    }
    
    @IBAction func confirmRefridgeratorButton(sender: UIButton) {
        
        //fridgeInfo = FridgeInfo()
        print(refridgeratorCompartments.text!)
        //fridgeInfo!.numOfDoors = Int(refridgeratorCompartments.text!)!
        
        //print(fridgeInfo!.numOfDoors)
        
        performSegueWithIdentifier("confirmFridgeSegue", sender: refridgeratorCompartments.text)
    
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "confirmFridgeSegue") {
            let nextVC:ConfirmFridgeViewController = segue.destinationViewController as! ConfirmFridgeViewController
            
//            nextVC.numOfDoors = fridgeInfo!.numOfDoors
            
              nextVC.numOfDoors = Int(refridgeratorCompartments.text!)
            
//            let data = sender as! FridgeInfo
//            print(data)
//            nextVC.confirmFridgeInfo = data
//            print(nextVC.confirmFridgeInfo)
        }
    }


    
}
