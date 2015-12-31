//
//  ThirdViewController.swift
//  FridgeApp
//
//  Created by Chase Peers on 9/5/15.
//  Copyright (c) 2015 Chase Peers. All rights reserved.
//

import UIKit

class ListViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    
    //var mainList = [String:[]]
    var mainList = Lists()
    var list: [String] = []
    
    // Temporary Sample
    func sampleIngredients() {
        
        print("mainList")
        print(mainList)
        
        //let list1Dic = ["Super1 List" : [1:"Carrots", 2:"Brocolli"]]
        let list1Dic = [1:"Carrots", 2:"Brocolli"]
        //let list1 = Lists.addList("Super 1 List", list1Dic)
        mainList.addList("Super 1 List", listDetail: list1Dic)
        //let list1 = Lists(listName: "Super 1 List", listDetail: list1Dic)
        
        print("mainList")
        print(mainList)
        
        //let list2Dic = ["Super 2 List" : [1:"Potatoes", 2:"Milk", 3:"Eggs"]]
        let list2Dic = [1:"Potatoes", 2:"Milk", 3:"Eggs"]
        mainList.addList("Super 2 List", listDetail: list2Dic)
        //let list2 = Lists(lists: list2Dic)!
        
        print("mainList")
        print(mainList)
        
        //let list3Dic = ["Super 3 List" : [1:"Juice", 2: "Pop"]]
        let list3Dic = [1:"Juice", 2: "Pop"]
        mainList.addList("Super 3 List", listDetail: list3Dic)
        //let list3 = Lists(lists: list3Dic)
        
        print("mainList")
        print(mainList)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
        let FTBC = self.tabBarController as! FridgeTabBarController
        mainList = FTBC.ShoppingLists
        
        sampleIngredients()
        
        // Dictionary not sorted by key
        list = Array(mainList.lists.keys).sort(<)
        
        // Get rid of any blank name lists
        if list.contains("") {
            let index = list.indexOf("")
            list.removeAtIndex(index!)
        }
        
        print("saved key list")
        print(list)
        
        //list = ["test1", "test2", "test3", "test4", "test5", "test6", "test7", "test8", "test9"]
    
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.backgroundColor = UIColor.whiteColor()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        print("vwa")
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
        
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        print(list.count)
        return list.count
        
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ListCollectionViewCell", forIndexPath: indexPath) as! ListCollectionViewCell
        
        cell.contentView.layer.cornerRadius = 2.0
        
        cell.listName.setTitle(list[indexPath.row], forState: .Normal)
        print(list[indexPath.row])
        
        return cell
        
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        print("goinghere?")
        //self.performSegueWithIdentifier("EditList", sender: self)
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let listDetailViewController = segue.destinationViewController as! ListDetailsViewController
        
        //ingredientDetailViewController.locationPickerData = myFridge.doorNames
        
        print("Segue identifier")
        print(segue.identifier!)
        
        if segue.identifier! == "EditList" {
            
            // Which cell is the sender?
            //if let selectedList = sender as? ListCollectionViewCell {
            //let indexPath = collectionView.indexPathForCell(sender as! ListCollectionViewCell)
            //let cell = sender as! ListViewController
            //let indexPaths = self.collectionView.indexPathForCell(cell)
            let indexPaths = self.collectionView.indexPathsForSelectedItems()!
            let indexPath = indexPaths[0] as NSIndexPath
            let selectedList = list[indexPath.row]
            listDetailViewController.listName = list[indexPath.row]
            listDetailViewController.listDetails = mainList.lists[selectedList]!
            print("Edit list")
                
                //ingredientDetailViewController.locationPickerData = myFridge.doorNames
                
            //}
            
        }
        //else {
        //    print("Segue identifier")
        //    print(segue.identifier)
            
        //}
        
    }

}
