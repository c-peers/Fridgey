//
//  FridgeViewController.swift
//  FridgeApp
//
//  Created by Chase Peers on 9/5/15.
//  Copyright (c) 2015 Chase Peers. All rights reserved.
//

import UIKit

class FridgeViewController: UIViewController, UIPageViewControllerDataSource, TabBarDelegate {

    var MyFridge: FridgeInfo?
    
    var pageViewController: UIPageViewController!
    var viewControllers: NSArray!
    var fridgeTitles: NSArray!
    var fridgeImages: NSArray!

//    required init(coder aDecoder: NSCoder!) {
//        super.init(coder: aDecoder)!
//    }
//    
//    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
//        
//        
//        if let savedFridge = loadFridge() {
//            
//            let FTBC = self.tabBarController as! FridgeTabBarController
//            var saveToFTBC = self.tabBarController as! FridgeTabBarController
//
//            MyFridge = savedFridge
//            saveToFTBC.MyFridge = savedFridge
//            
//            print("Saved Fridge")
//            print(MyFridge?.numOfDoors)
//            print(MyFridge?.doorNames)
//            print(MyFridge?.fridgeName)
//            
//        } else {
//            
//            // No fridge, set defaults... for now.
//            MyFridge = FridgeInfo(fridgeName: "Fridge", numOfDoors: 2, doorNames: ["1", "2"])!
//        }
//        
//        // Must call designated initializer.
//        self.init()
//        
//    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        if (MyFridge != nil) {
//            
//            // self.fridgeTitles = NSArray(objects: "A", "B")
//            // self.fridgeImages = NSArray(objects: "1", "2")
//            self.fridgeTitles = NSArray(object: (MyFridge?.fridgeName)!)
//            self.fridgeImages = NSArray(objects: "1")
//
//        } else {
//            
//            self.fridgeTitles = NSArray(object: "Add a Fridge")
//            self.fridgeImages = NSArray(object: "Blank")
//            
//        }
//        
//        self.pageViewController = self.storyboard?.instantiateViewControllerWithIdentifier("FridgePageView") as! UIPageViewController
//        
//        self.pageViewController.dataSource = self
//        
//        var startVC = self.viewControllerAtIndex(0) as FridgePageContentViewController
//        viewControllers = NSArray(object: startVC)
//        
//        self.pageViewController.setViewControllers(viewControllers as! [UIViewController], direction: .Forward, animated: true, completion: nil)
//        
//        self.pageViewController.view.frame = CGRectMake(30, 30, self.view.frame.width - 60, self.view.frame.height - 100)
//        
//        self.addChildViewController(self.pageViewController)
//        self.view.addSubview(self.pageViewController.view)
//        self.pageViewController.didMoveToParentViewController(self)
//        
//        if let pageViewController = parentViewController as? UIPageViewController {
//            pageViewController.setViewControllers(viewControllers as! [UIViewController], direction: .Forward, animated: true, completion: nil)
//        }
//        
//        pageViewController.setViewControllers(viewControllers as! [UIViewController], direction: .Forward, animated: true, completion: nil)
        
        PersistManager.sharedManager.initialLoading()
        
        print(PersistManager.sharedManager.MyFridge.doorNames)
        
        let FTBC = self.tabBarController as! FridgeTabBarController
        let saveToFTBC = self.tabBarController as! FridgeTabBarController
        
        //MyFridge = FTBC.MyFridge
        
        //print(MyFridge?.numOfDoors)
        
        MyFridge = PersistManager.sharedManager.MyFridge
        
        //if let savedFridge = PersistManager.sharedManager.loadFridge() {
//        if let savedFridge = PersistManager.sharedManager.decode() {
//        
//            MyFridge = savedFridge
//            print(savedFridge)
//            //saveToFTBC.MyFridge = savedFridge
//            
//            print("Saved Fridge")
//            print(MyFridge?.numOfDoors)
//            print(MyFridge?.doorNames)
//            print(MyFridge?.fridgeName)
//            
//        } else {
//            
//            // No fridge, set defaults... for now.
//            MyFridge = FridgeInfo(fridgeName: "Fridge", numOfDoors: 2, doorNames: ["1", "2"])!
//        }
        
        let loadSingleton = PersistenceHandler()
        loadSingleton.load("Fridge")
        loadSingleton.load("Lists")
        
        print(PersistManager.sharedManager.MyFridge.doorNames)
        
        MyFridge = PersistManager.sharedManager.MyFridge
        
        setPageViewController()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func viewWillAppear() {
        
        if (MyFridge?.numOfDoors != 0) && (MyFridge != nil) {

            print("not nil!")
            // self.fridgeTitles = NSArray(objects: "A", "B")
            // self.fridgeImages = NSArray(objects: "1", "2")
            self.fridgeTitles = NSArray(object: (MyFridge?.fridgeName)!)
            self.fridgeImages = NSArray(objects: "1")
        
//        if (MyFridge != nil) {
//            
//            print("not nil!")
//            // self.fridgeTitles = NSArray(objects: "A", "B")
//            // self.fridgeImages = NSArray(objects: "1", "2")
//            self.fridgeTitles = NSArray(object: (MyFridge?.fridgeName)!)
//            self.fridgeImages = NSArray(objects: "1")
//            
        } else {
            print("Fridge not set, viewWillAppear")
            //self.fridgeTitles = NSArray(object: "Add a Fridge")
            //self.fridgeImages = NSArray(object: "Blank")
            self.fridgeTitles = NSArray(object: "Add a Fridge")
            self.fridgeImages = NSArray(object: "Blank")
            
        }

        if let pageViewController = parentViewController as? UIPageViewController {
            pageViewController.setViewControllers(viewControllers as? [UIViewController], direction: .Forward, animated: true, completion: nil)
        }
        
        pageViewController.setViewControllers(viewControllers as? [UIViewController], direction: .Forward, animated: true, completion: nil)

        
        
    }

    func didSelectTab(tabBarController: FridgeTabBarController) {
        print("first!")
    }
    
    
    // MARK: PageView
    
    func setPageViewController() {
        
        if (MyFridge?.numOfDoors != 0) && (MyFridge != nil) {

            print("not zero! set page")
            // self.fridgeTitles = NSArray(objects: "A", "B")
            // self.fridgeImages = NSArray(objects: "1", "2")
            self.fridgeTitles = NSArray(object: (MyFridge?.fridgeName)!)
            self.fridgeImages = NSArray(objects: "1")
            
        } else {

            print("zero! set page")
            self.fridgeTitles = NSArray(object: "Add a Fridge")
            self.fridgeImages = NSArray(object: "Blank")
            
        }
        
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
        
        vc.FridgeImage = self.fridgeImages[index] as! String
        vc.fridgeIndex = self.fridgeTitles[index] as! String
        vc.pageIndex = index
        
        return vc
        
    }
    
    
    // MARK: PageView Data Source
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        
        let vc = viewController as! FridgePageContentViewController
        var index = vc.pageIndex as Int
        
        if (index == 0) || (index == NSNotFound) {
            
            return nil
        }
        
        index--
        
        return self.viewControllerAtIndex(index)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        
        let vc = viewController as! FridgePageContentViewController
        var index = vc.pageIndex as Int
        
        if (index == NSNotFound) {
            return nil
        }
        
        index++
        
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
        
        if let sourceViewController = sender.sourceViewController as? ConfirmFridgeViewController {
            
            MyFridge = sourceViewController.myFridge
            
            print("Saved Fridge")
            print(MyFridge!.numOfDoors)
            print(MyFridge!.doorNames)
            print(MyFridge!.fridgeName)
            
            // Save ingredients
            //saveFridge()
            //PersistManager.sharedManager.saveFridge()
            //PersistManager.sharedManager.encode()
            
            PersistManager.sharedManager.MyFridge = MyFridge!
            
            print(PersistManager.sharedManager.MyFridge.doorNames)
            
            let saveSingleton = PersistenceHandler()
            saveSingleton.save()
            
            if (MyFridge?.numOfDoors != 0) && (MyFridge != nil) {
                
                // self.fridgeTitles = NSArray(objects: "A", "B")
                // self.fridgeImages = NSArray(objects: "1", "2")
                self.fridgeTitles = NSArray(object: (MyFridge?.fridgeName)!)
                self.fridgeImages = NSArray(objects: "1")
                
            } else {
                
                self.fridgeTitles = NSArray(object: "Add a Fridge")
                self.fridgeImages = NSArray(object: "Blank")
                
            }
            
            //if let pageViewController = parentViewController as? UIPageViewController {
            //    pageViewController.setViewControllers(viewControllers as! [UIViewController], direction: .Forward, animated: true, completion: nil)
            //}
            
            //self.pageViewController.setViewControllers(viewControllers as! [UIViewController], direction: .Forward, animated: true, completion: nil)

            setPageViewController()
            
            //loadView()
            
            
        }
        
    }

    // MARK: NSCoding
    func saveFridge() {
        
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(MyFridge!, toFile: FridgeInfo.ArchiveURL.path!)
        
        if !isSuccessfulSave {
            print("Couldn't save")
        }
        
    }
    
    func loadFridge() -> FridgeInfo? {
        
        return NSKeyedUnarchiver.unarchiveObjectWithFile(FridgeInfo.ArchiveURL.path!) as? FridgeInfo
        
    }

    
    
}

