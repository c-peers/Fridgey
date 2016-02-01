//
//  ThirdViewController.swift
//  FridgeApp
//
//  Created by Chase Peers on 9/5/15.
//  Copyright (c) 2015 Chase Peers. All rights reserved.
//

import UIKit

class ListViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UITextFieldDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var mainList = Lists()
    var list: [String] = []
    
    // Text Field Delegate objects
    let ListTextFieldDelegate = ListViewCollectionTextFieldDelegate()
    
    // Temporary Sample    
    func sampleLists() {
        
        print("mainList")
        print(mainList)
        
        //let list1Dic = ["Super1 List" : [1:"Carrots", 2:"Brocolli"]]
        let list1Dic = ["Carrots", "Brocolli"]
        //let list1 = Lists.addList("Super 1 List", list1Dic)
        mainList.addList("Super 1 List", listDetail: list1Dic)
        //let list1 = Lists(listName: "Super 1 List", listDetail: list1Dic)
        
        print("mainList")
        print(mainList)
        
        //let list2Dic = ["Super 2 List" : [1:"Potatoes", 2:"Milk", 3:"Eggs"]]
        let list2Dic = ["Potatoes", "Milk", "Eggs"]
        mainList.addList("Super 2 List", listDetail: list2Dic)
        //let list2 = Lists(lists: list2Dic)!
        
        print("mainList")
        print(mainList)
        
        //let list3Dic = ["Super 3 List" : [1:"Juice", 2: "Pop"]]
        let list3Dic = ["Juice", "Pop"]
        mainList.addList("Super 3 List", listDetail: list3Dic)
        //let list3 = Lists(lists: list3Dic)
        
        print("mainList")
        print(mainList)
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
        //let FTBC = self.tabBarController as! FridgeTabBarController
        //mainList = FTBC.ShoppingLists
        
//        if let savedLists = PersistManager.sharedManager.loadList() {
//            
//            mainList = savedLists
//            
//        } else {
//            
//            // Load the sample data.
//            sampleIngredients()
//            
//        }
        
        let loadSingleton = PersistenceHandler()
        print(loadSingleton.load("Lists"))

        mainList = PersistManager.sharedManager.ShoppingLists
        
        //sampleLists()
        
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
        
        self.subscribeToKeyboardNotifications()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        //self.unsubscribeFromKeyboardNotifications()
    }
    
    func viewWillAppear() {
        print("vwa")
        mainList = PersistManager.sharedManager.ShoppingLists
        
        print(mainList.lists)
    }
    
    func subscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        //NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func keyboardWillShow(notification: NSNotification) {
        self.view.frame.origin.y -= getKeyboardHeight(notification)
    }
    
    func keyboardWillHide(notification: NSNotification) {
        self.view.frame.origin.y += getKeyboardHeight(notification)
    }
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.CGRectValue().height
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
        
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return list.count
        
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ListCollectionViewCell", forIndexPath: indexPath) as! ListCollectionViewCell
        
        cell.nameNewListText.hidden = true
        
        cell.contentView.layer.cornerRadius = 2.0
        
        cell.layer.cornerRadius = 8
        
        print(list[indexPath.row])
        
        if list[indexPath.row] == "To Name" {
            print("are you coming here?")
            cell.listName.text = ""
            cell.nameNewListText.hidden = false
            cell.nameNewListText.returnKeyType = UIReturnKeyType.Done
            cell.nameNewListText.delegate = self
            //cell.nameNewListText.becomeFirstResponder()
            cell.nameNewListText.performSelector("becomeFirstResponder", withObject: nil, afterDelay: 0)
                        
        } else {
            cell.listName.text = list[indexPath.row]
        }
        
        //cell.listName.setTitle(list[indexPath.row], forState: .Normal)
        
        return cell
        
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        print("goinghere?")
        //self.performSegueWithIdentifier("EditList", sender: self)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        
        print("entered?")
        
        let indexPath = NSIndexPath(forRow: list.count - 1, inSection: 0)
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ListCollectionViewCell", forIndexPath: indexPath) as! ListCollectionViewCell
        
        cell.listName.text = textField.text
        
        print(mainList.lists)
        
        // We have our actual List name now so rename the lists and remove the temporary list.
        list[list.count - 1] = textField.text!
        let toRemoveIndex = mainList.lists.indexForKey("To Name")
        mainList.lists.removeAtIndex(toRemoveIndex!)
        mainList.addList(textField.text!, listDetail: [])
        
        print(mainList.lists)
        
        // We only needed the textField so write the label name. Now let's hide the field.
        textField.hidden = true
        textField.text = nil
        textField.alpha = 0.0
        
        // We just added a new list so let's save.
        let saveList = PersistenceHandler()
        saveList.save()
        
        collectionView.reloadData()
        
    }


    @IBAction func addNewList() {
        
        //Make a temporary list so that the collection view doesn't cause a crash because the array is out of bounds.
        list.append("To Name")
        
        let listItems = []
        mainList.addList("To Name", listDetail: listItems as! [String])
        
        let indexPath = NSIndexPath(forRow: list.count - 1, inSection: 0)
        collectionView.insertItemsAtIndexPaths([indexPath])
        collectionView.reloadData()
        
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
            print(selectedList)
            listDetailViewController.listName = list[indexPath.row]
            listDetailViewController.listDetails = mainList.lists[selectedList]!
            //listDetailViewController.listDetailsDic = mainList.lists[selectedList]!
            print("Edit list")
                
                //ingredientDetailViewController.locationPickerData = myFridge.doorNames
                
            //}
            
        }
        //else {
        //    print("Segue identifier")
        //    print(segue.identifier)
            
        //}
        
    }
    
    
    
    // MARK: NSCoding
    func saveList() {
        
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(mainList, toFile: Lists.ArchiveURL.path!)
        
        let FTBC = self.tabBarController as! FridgeTabBarController
        FTBC.ShoppingLists = mainList
        
        if !isSuccessfulSave {
            print("Couldn't save")
        }
        
    }
    
    func loadList() -> Lists? {
        
        return NSKeyedUnarchiver.unarchiveObjectWithFile(Lists.ArchiveURL.path!) as? Lists
        
    }


}
