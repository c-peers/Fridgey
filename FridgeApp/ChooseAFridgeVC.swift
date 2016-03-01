//
//  ChooseAFridge.swift
//  FridgeApp
//
//  Created by Chase Peers on 9/20/15.
//  Copyright © 2015 Chase Peers. All rights reserved.
//

import UIKit

class ChooseAFridgeViewController: UIViewController, UIPageViewControllerDataSource {
    
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

        setPageViewController()

    }
    
//    @IBAction func changeFridgeDoorNum(sender: UIStepper) {
//        refridgeratorCompartments.text = Int(sender.value).description
//        
//    }

    // MARK: PageView
    
    func setPageViewController() {
        
        fridgeImages = fridgeImageList
        //self.fridgeImages = NSArray(object: fridgeImageList)
        //self.fridgeImages = NSArray(object: "Blank")
        
        self.pageViewController = self.storyboard?.instantiateViewControllerWithIdentifier("ChooseAFridgePageView") as! UIPageViewController
        
        self.pageViewController.dataSource = self
        
        let startVC = self.viewControllerAtIndex(0) as ChooseAFridgePageContentViewController
        viewControllers = NSArray(object: startVC)
        
        self.pageViewController.setViewControllers(viewControllers as? [UIViewController], direction: .Forward, animated: true, completion: nil)
        
        self.pageViewController.view.frame = CGRectMake(30, 30, self.view.frame.width - 60, self.view.frame.height - 100)
        
        self.addChildViewController(self.pageViewController)
        self.view.addSubview(self.pageViewController.view)
        self.pageViewController.didMoveToParentViewController(self)
        
        if let pageViewController = parentViewController as? UIPageViewController {
            pageViewController.setViewControllers(viewControllers as? [UIViewController], direction: .Forward, animated: true, completion: nil)
        }
        
        pageViewController.setViewControllers(viewControllers as? [UIViewController], direction: .Forward, animated: true, completion: nil)
        
    }
    
    func viewControllerAtIndex(index: Int) -> ChooseAFridgePageContentViewController {
        
        if ((self.fridgeImages.count == 0) || (index >= self.fridgeImages.count)) {
            return ChooseAFridgePageContentViewController()
        }
        
        let vc: ChooseAFridgePageContentViewController = self.storyboard?.instantiateViewControllerWithIdentifier("ChooseAFridgePageContentViewController") as! ChooseAFridgePageContentViewController
        
        vc.FridgeImage = self.fridgeImages[index] as! String
        vc.pageIndex = index
        imageIndex = index
        
        return vc
        
    }
    
    
    // MARK: PageView Data Source
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        
        let vc = viewController as! ChooseAFridgePageContentViewController
        let index = vc.pageIndex as Int
        let previousIndex = index - 1
        
        guard previousIndex >= 0 else {
            return self.viewControllerAtIndex(self.fridgeImages.count - 1)
        }
        
        guard self.fridgeImages.count > previousIndex else {
            return nil
        }
        
        //if (index == 0) || (index == NSNotFound) {
        //    return nil
        //}
        
        
        return self.viewControllerAtIndex(previousIndex)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        
        let vc = viewController as! ChooseAFridgePageContentViewController
        let index = vc.pageIndex as Int
        let nextIndex = index + 1
        
        guard self.fridgeImages.count != nextIndex else {
            return self.viewControllerAtIndex(0)
        }
        
        guard self.fridgeImages.count > nextIndex else {
            return nil
        }
        
//        if (index == NSNotFound) {
//            return nil
//        }
//        
//        if (index == self.fridgeImages.count) {
//            return nil
//        }
        
        return self.viewControllerAtIndex(nextIndex)
        
    }
    
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
