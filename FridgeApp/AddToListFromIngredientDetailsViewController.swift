//
//  AddToListFromIngredientDetailsViewController.swift
//  FridgeApp
//
//  Created by Chase Peers on 12/21/15.
//  Copyright © 2015 Chase Peers. All rights reserved.
//

import UIKit

class AddToListFromIngredientDetailsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var list: [String] = []
    var mainList = Lists()
    var selectedIngredient = String()
    var selectedList: String = ""
    //var globalVars = PersistManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //list = ["test1", "test2", "test3", "test4", "test5", "test6", "test7", "test8", "test9"]
        
        mainList = PersistManager.sharedManager.ShoppingLists
        
        //if let savedLists = PersistManager.sharedManager.loadList() {
        //    mainList = savedLists
        //}
        
        // Dictionary not sorted by key
        list = Array(mainList.lists.keys).sort(<)
        
        // Get rid of any blank name lists
        if list.contains("") {
            let index = list.indexOf("")
            list.removeAtIndex(index!)
        }
    
        print(selectedIngredient)
        print(mainList.lists)
        print(list)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.backgroundColor = UIColor.whiteColor()
        
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
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
        
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        print(list.count)
        return list.count
        
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("FromIngredientsToListCollectionViewCell", forIndexPath: indexPath) as! AddToListFromIngredientsCollectionViewCell
        
        cell.contentView.layer.cornerRadius = 2.0
        
        //cell.listName.setTitle(list[indexPath.row], forState: .Normal)
        cell.listName.text = list[indexPath.row]
        print(list[indexPath.row])
        
        return cell
        
    }
    
    //func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {

        print("selected?")
        selectedList = list[indexPath.row]
        let selectedListCount = mainList.lists[selectedList]?.count
        print(mainList.lists[selectedList])
        mainList.lists[selectedList]![selectedListCount! + 1] = selectedIngredient
        
        print(mainList.lists[selectedList])

        PersistManager.sharedManager.ShoppingLists.lists[selectedList] = mainList.lists[selectedList]
        
        // Save lists
        let saveList = PersistenceHandler()
        saveList.save()
        
        print(PersistManager.sharedManager.ShoppingLists.lists)
        
        //dismissViewControllerAnimated(true, completion: nil)
        
        //Can't do a regular unwind segue because then this whole function is called out of order. Perform the unwind manually so that the above can run.
        print("manual unwind")
        self.performSegueWithIdentifier("addToListSelected", sender: self)
        
        }
    
    @IBAction func cancelAddToList(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
    }

}
