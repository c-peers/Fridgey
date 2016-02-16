//
//  AddToListFromExpiry.swift
//  FridgeApp
//
//  Created by Chase Peers on 2/16/16.
//  Copyright © 2016 Chase Peers. All rights reserved.
//

import UIKit

class AddToListFromExpiryViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var list: [String] = []
    var mainList = Lists()
    var selectedIngredients: [String] = []
    var selectedList: String = ""
    
    var previousVC = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainList = PersistManager.sharedManager.ShoppingLists
        
        // Dictionary not sorted by key
        list = Array(mainList.lists.keys).sort(<)
        
        // Get rid of any blank name lists
        if list.contains("") {
            let index = list.indexOf("")
            list.removeAtIndex(index!)
        }
        
        print(selectedIngredients)
        print(mainList.lists)
        print(list)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.backgroundColor = UIColor.whiteColor()
        
        self.view.backgroundColor = UIColor(white: 0, alpha: 0.4)
        
        backgroundView.layer.cornerRadius = 8
        backgroundView.layer.masksToBounds = true
        
        backgroundView.layer.borderColor = UIColor.grayColor().CGColor
        backgroundView.layer.borderWidth = 0.5
        
        backgroundView.layer.shadowColor = UIColor.blackColor().CGColor
        backgroundView.layer.shadowOffset = CGSizeZero
        backgroundView.layer.shadowRadius = 5.0
        backgroundView.layer.shadowOpacity = 0.5
        backgroundView.layer.masksToBounds = false
        backgroundView.clipsToBounds = false
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        print(list.count)
        return list.count
        
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("FromExpiryToListCollectionViewCell", forIndexPath: indexPath) as! AddToListFromExpiryCollectionViewCell
        
        cell.contentView.layer.cornerRadius = 2.0
        cell.layer.cornerRadius = 8
        
        //cell.listName.setTitle(list[indexPath.row], forState: .Normal)
        cell.listName.text = list[indexPath.row]
        print(list[indexPath.row])
        
        return cell
        
    }
    
    //func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        print("selected?")
        selectedList = list[indexPath.row]
        var listDetails = mainList.lists[selectedList]
        
        print(listDetails)
        
        listDetails! += selectedIngredients
        //mainList.lists[selectedList]!.append(selectedIngredients)
        
        print(listDetails)
        
        PersistManager.sharedManager.ShoppingLists.lists[selectedList] = listDetails
        
        // Save lists
        let saveList = PersistenceHandler()
        saveList.save()
        
        print(PersistManager.sharedManager.ShoppingLists.lists)
        
        //Can't do a regular unwind segue because then this whole function is called out of order. Perform the unwind manually so that the above can run.
        
        print("manual unwind to new/edit ingredient")
        self.performSegueWithIdentifier("addToListFromExpirySegue", sender: self)
        
    }
    
    @IBAction func cancelAddToList(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
}
