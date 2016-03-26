//
//  FridgeViewController.swift
//  FridgeApp
//
//  Created by Chase Peers on 9/5/15.
//  Copyright (c) 2015 Chase Peers. All rights reserved.
//

import UIKit

class FridgeViewController: UIViewController, UIPageViewControllerDataSource {

    @IBOutlet weak var addEditFridge: UIBarButtonItem!

    var MyFridge: FridgeInfo?
    
    var pageViewController: UIPageViewController!
    var viewControllers: NSArray!
    var fridgeTitles: [String]!
    var fridgeImages: [String]!
    var myFridgeImage: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let loadSingleton = PersistenceHandler()
        loadSingleton.load("Fridge")
        loadSingleton.load("Ingredients")
        loadSingleton.load("Lists")
        
        MyFridge = PersistManager.sharedManager.MyFridge
        
        if let _ = MyFridge?.fridgeName {
            addEditFridge.title = "Change Fridge"
            print("Plus title")
            print(addEditFridge.title)
        }
        
        setFridgeInfo()
        setPageViewController()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func checkFridgeImage() {
        if let _ = MyFridge?.fridgeImage {
            print("It's ok")
            myFridgeImage = MyFridge!.fridgeImage
        } else {
            myFridgeImage = "Blank"
        }
        
    }
    
    func setFridgeInfo() {
        
        if (MyFridge?.numOfDoors != 0) && (MyFridge != nil) {
            
            checkFridgeImage()
            
            print("not nil!")
            // self.fridgeTitles = NSArray(objects: "A", "B")
            // self.fridgeImages = NSArray(objects: "1", "2")
            self.fridgeTitles = [MyFridge!.fridgeName]
            self.fridgeImages = [myFridgeImage]
            
            //self.fridgeTitles.append(MyFridge!.fridgeName)
            //self.fridgeImages.append(myFridgeImage)
            
            print("fridge title")
            print(self.fridgeTitles)
            
        } else {
            print("Fridge not set, viewWillAppear")
            self.fridgeTitles.append("Add a Fridge")
            self.fridgeImages.append("Blank")
            
        }
        
    }
    
//    func viewWillAppear() {
//        
//        print("check")
//        
//        setFridgeInfo()
//
//        if let pageViewController = parentViewController as? UIPageViewController {
//            pageViewController.setViewControllers(viewControllers as? [UIViewController], direction: .Forward, animated: true, completion: nil)
//        }
//        
//        pageViewController.setViewControllers(viewControllers as? [UIViewController], direction: .Forward, animated: true, completion: nil)
//        
//        setPageViewController()
//        
//    }

    
    // MARK: PageView
    
    func setPageViewController() {
        
        self.pageViewController = self.storyboard?.instantiateViewControllerWithIdentifier("FridgePageView") as! UIPageViewController
        
        self.pageViewController.dataSource = self
        
        let startVC = self.viewControllerAtIndex(0) as FridgePageContentViewController
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
    
    func viewControllerAtIndex(index: Int) -> FridgePageContentViewController {
        
        if ((self.fridgeTitles.count == 0) || (index >= self.fridgeTitles.count)) {
            return FridgePageContentViewController()
        }
        
        let vc: FridgePageContentViewController = self.storyboard?.instantiateViewControllerWithIdentifier("FridgePageContentViewController") as! FridgePageContentViewController
        
        vc.fridgeImage = self.fridgeImages[index]
        vc.fridgeIndex = self.fridgeTitles[index] 
        vc.pageIndex = index
        
        self.navigationItem.title = fridgeTitles[index]
        
        print("fridge title")
        print(self.fridgeTitles)
        print(vc.fridgeIndex)
        
        return vc
        
    }
    
    
    // MARK: PageView Data Source
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        
        let vc = viewController as! FridgePageContentViewController
        var index = vc.pageIndex as Int
        
        if (index == 0) || (index == NSNotFound) {
            
            return nil
        }
        
        index -= 1
        
        return self.viewControllerAtIndex(index)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        
        let vc = viewController as! FridgePageContentViewController
        var index = vc.pageIndex as Int
        
        if (index == NSNotFound) {
            return nil
        }
        
        index += 1
        
        if (index == self.fridgeTitles.count) {
            return nil
        }
        
        return self.viewControllerAtIndex(index)
        
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        
        return self.fridgeTitles.count
        
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        
        return 0
        
    }
    
    
    @IBAction func unwindToMyFridge(sender: UIStoryboardSegue) {
        
        if let sourceViewController = sender.sourceViewController as? ChooseAFridgeViewController {
            
            MyFridge = sourceViewController.myFridge
            
            let imageIndex = sourceViewController.imageIndex
            myFridgeImage = sourceViewController.selectedFridge
            
            print("Saved Fridge")
            print(MyFridge!.numOfDoors)
            print(MyFridge!.doorNames)
            print(MyFridge!.fridgeName)
            print(MyFridge!.fridgeImage)
            
            PersistManager.sharedManager.MyFridge = MyFridge!
            
            print(PersistManager.sharedManager.MyFridge.doorNames)
            
            let saveSingleton = PersistenceHandler()
            saveSingleton.save()
            
            setFridgeInfo()
            
//            if (MyFridge?.numOfDoors != 0) && (MyFridge != nil) {
//                
//                // self.fridgeTitles = NSArray(objects: "A", "B")
//                // self.fridgeImages = NSArray(objects: "1", "2")
//                //self.fridgeTitles.append(MyFridge!.fridgeName)
//                //self.fridgeImages.append(myFridgeImage)
//                self.fridgeTitles = [MyFridge!.fridgeName]
//                self.fridgeImages = [myFridgeImage]
//                
//                print(MyFridge!.fridgeName)
//                
//            } else {
//                
//                self.fridgeTitles.append("Add a Fridge")
//                self.fridgeImages.append("Blank")
//                
//            }
            
            setPageViewController()
        
        }
        
    }
    
}

