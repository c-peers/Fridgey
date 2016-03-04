//
//  ChooseAFridgePageView.swift
//  FridgeApp
//
//  Created by Chase Peers on 3/2/16.
//  Copyright © 2016 Chase Peers. All rights reserved.
//

import UIKit

class ChooseAFridgePageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    var pages = [UIViewController]()
    //var pageViewController: UIPageViewController!
    //var viewControllers: NSArray!
    
    var myFridge: FridgeInfo!
    var numOfDoors: Int!
    
    var fridgeImages: NSArray!
    var imageIndex: Int!
    
    var fridgeInfo: FridgeInfo?
    
    let fridgeImageList = ["2_door_mini", "2_door", "3_door", "4_door", "4_door-2", "5_door", "6_door", "6_door-2", "french_door", "side_by_side"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        self.dataSource = self
    
        fridgeImages = fridgeImageList
        
        //self.pageViewController = self.storyboard?.instantiateViewControllerWithIdentifier("ChooseAFridgePageView") as! UIPageViewController
        
        //self.pageViewController.dataSource = self
        
        let startVC = self.viewControllerAtIndex(0) as ChooseAFridgePageContentViewController
        pages = [startVC]
        
        setViewControllers(pages, direction: .Forward, animated: true, completion: nil)
        
//        self.pageViewController.view.frame = CGRectMake(30, 30, self.view.frame.width - 60, self.view.frame.height - 100)
//        
//        self.addChildViewController(self.pageViewController)
//        self.view.addSubview(self.pageViewController.view)
//        self.pageViewController.didMoveToParentViewController(self)
        
    }
    
    func viewControllerAtIndex(index: Int) -> ChooseAFridgePageContentViewController {
        
        if ((self.fridgeImages.count == 0) || (index >= self.fridgeImages.count)) {
            return ChooseAFridgePageContentViewController()
        }
        
        let vc: ChooseAFridgePageContentViewController = self.storyboard?.instantiateViewControllerWithIdentifier("ChooseAFridgePageContentViewController") as! ChooseAFridgePageContentViewController
        
        vc.FridgeImage = self.fridgeImages[index] as! String
        vc.pageIndex = index
        //imageIndex = index
        
        return vc
        
    }
    
    func pageViewController(pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        let pageContentViewController = pageViewController.viewControllers![0] as! ChooseAFridgePageContentViewController
        imageIndex = pageContentViewController.pageIndex
        
        //let fridgeVC = self.storyboard?.instantiateViewControllerWithIdentifier("ChooseAFridge") as! ChooseAFridgeViewController
        
        //fridgeVC.imageIndex = imageIndex
        
        print("index")
        print(imageIndex)
        
       PersistManager.sharedManager.fridgeChooser.imageIndex = imageIndex
        
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

}