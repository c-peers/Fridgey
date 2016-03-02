//
//  ChooseAFridge.swift
//  FridgeApp
//
//  Created by Chase Peers on 9/20/15.
//  Copyright © 2015 Chase Peers. All rights reserved.
//

import UIKit

class ChooseAFridgeViewController: UIViewController {
    
    var pageViewController: UIPageViewController!
    var viewControllers: NSArray!
    
    var myFridge: FridgeInfo!
    var numOfDoors: Int!
  
    var fridgeImages: NSArray!
    var imageIndex: Int!
    
    var fridgeInfo: FridgeInfo?
    
    let fridgeImageList = ["2_door_mini", "2_door", "3_door", "4_door", "4_door-2", "5_door", "6_door", "6_door-2", "french_door", "side_by_side"]
    
    //@IBOutlet weak var refridgeratorCompartments: UILabel!
    //@IBOutlet weak var stepper: UIStepper!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        stepper.wraps = true
//        stepper.autorepeat = true
//        stepper.maximumValue = 7
//        stepper.minimumValue = 1

    }
    
//    @IBAction func changeFridgeDoorNum(sender: UIStepper) {
//        refridgeratorCompartments.text = Int(sender.value).description
//        
//    }

    
//    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
//        
//        return self.fridgeImages.count
//        
//    }
//    
//    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
//        
//        return 0
//        
//    }

    
    @IBAction func confirmRefridgeratorButton(sender: UIButton) {
        
        let actionTitle = "Do you have the selected refridgerator?"

        let alertController = UIAlertController(title: "Fridge Confirmation", message: actionTitle, preferredStyle: .Alert)
        alertController.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.Cancel,handler: {(alert: UIAlertAction!) in print("No");
            return
        }))
        alertController.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.Default, handler: {(alert: UIAlertAction!) in print("Confirm");
            
            self.performSegueWithIdentifier("fridgeChosen", sender: nil)
            
        }))
        
        self.presentViewController(alertController, animated: true, completion: nil)
        
        
    }
    
    
        
        //fridgeInfo = FridgeInfo()
        //print(refridgeratorCompartments.text!)
        //fridgeInfo!.numOfDoors = Int(refridgeratorCompartments.text!)!
        
        //print(fridgeInfo!.numOfDoors)
        
        //performSegueWithIdentifier("confirmFridgeSegue", sender: refridgeratorCompartments.text)

    
    // MARK: Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier != "chooseAFridgeEmbedPVC" {
        
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
        
        myFridge = FridgeInfo(fridgeName: fridgeName, numOfDoors: numOfDoors, doorNames: doorNames)!
        
        let fridgeImage = fridgeImages[imageIndex]

        }
    }
    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if (segue.identifier == "confirmFridgeSegue") {
//            let nextVC:ConfirmFridgeViewController = segue.destinationViewController as! ConfirmFridgeViewController
//            
////            nextVC.numOfDoors = fridgeInfo!.numOfDoors
//            
//              //nextVC.numOfDoors = Int(refridgeratorCompartments.text!)
//            
////            let data = sender as! FridgeInfo
////            print(data)
////            nextVC.confirmFridgeInfo = data
////            print(nextVC.confirmFridgeInfo)
//        }
//    }

}
