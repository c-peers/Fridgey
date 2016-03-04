//
//  ConfirmFridgeVC.swift
//  FridgeApp
//
//  Created by Chase Peers on 9/22/15.
//  Copyright © 2015 Chase Peers. All rights reserved.
//

import UIKit

class ConfirmFridgeViewController: UIViewController {
    
    @IBOutlet weak var fridgeConfirmationText: UILabel!
    @IBOutlet weak var confirmFridgeButton: UIButton!

    
    //var confirmFridgeInfo: FridgeInfo!
    var myFridge: FridgeInfo!
    var numOfDoors: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

//        confirmFridgeInfo = FridgeInfo()
//
//        print(confirmFridgeInfo.numOfDoors!)
//        
//        
//        numTest.text = String(confirmFridgeInfo.numOfDoors!)
        
        print(numOfDoors)
        
        
        fridgeConfirmationText.text = String(numOfDoors)
        
        switch numOfDoors {
        case 1:
            fridgeConfirmationText.text = "One Door Fridge"
        case 2:
            fridgeConfirmationText.text = "Two Door Fridge"
        case 3:
            fridgeConfirmationText.text = "Three Door Fridge"
        case 4:
            fridgeConfirmationText.text = "Four Door Fridge"
        case 5:
            fridgeConfirmationText.text = "Five Door Fridge"
        case 6:
            fridgeConfirmationText.text = "Six Door Fridge"
        case 7:
            fridgeConfirmationText.text = "Seven Door Fridge"
        default:
            fridgeConfirmationText.text = "Error"
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
//    @IBAction func confirmFridgeType(sender: UIButton) {
//    
//        
//        
//    }
    
    @IBAction func wrongFridgeType(sender: UIButton) {

        // navigationController?.popToViewController(ChooseAFridgeViewController, animated: true)
        navigationController?.popViewControllerAnimated(true)
        
    }
    
    
    @IBAction func confirmedFridgeType(sender: UIButton) {
        
    }
    
    
    // MARK: Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if confirmFridgeButton == (sender as? UIBarButtonItem) {
            
            // Default fridge name
            let fridgeName = "My Fridge"

            // The number of doors is already defined so skip that.
            
            // Initialize an array for the door names. And then add default names.
            var doorNames: [String] = []
        
            for x in 1...numOfDoors {
                print("doors")
                let tempName = "Area " + x.description + " Door"
                doorNames.append(tempName)
            }
            
            //myFridge = FridgeInfo(fridgeName: fridgeName, numOfDoors: numOfDoors, doorNames: doorNames)!
            

        }
    }
}

