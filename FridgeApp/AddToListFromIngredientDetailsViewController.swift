//
//  AddToListFromIngredientDetailsViewController.swift
//  FridgeApp
//
//  Created by Chase Peers on 12/21/15.
//  Copyright © 2015 Chase Peers. All rights reserved.
//

import UIKit

class AddToListFromIngredientDetailsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UITextFieldDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var newListButton: UIButton!
    @IBOutlet weak var newListButtonBGView: UIView!
    @IBOutlet weak var newListText: UITextField!
    
    var list: [String] = []
    var mainList = Lists()
    var selectedIngredient = String()
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
        
        print("selectedIngredient")
        print(selectedIngredient)
        print(mainList.lists)
        print(list)
        
        // Hook Up Colection View
        collectionView.dataSource = self
        collectionView.delegate = self
        
        
        // Make it look like the view is on top of the previous view
        collectionView.backgroundColor = UIColor.whiteColor()
        
        self.view.backgroundColor = UIColor(white: 0, alpha: 0.4)
        
        // Round corners and shadows
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
        
        newListButtonBGView.layer.cornerRadius = 8
        newListButtonBGView.layer.masksToBounds = true
        
        newListText.hidden = true
        newListText.delegate = self
        
        newListButton.hidden = false
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        
        print("entered?")
        
        // We have our actual List name now so rename the lists and remove the temporary list.
        selectedList = textField.text!
        
        newListButton.setTitle(selectedList, forState: .Normal)
        
        list[list.count - 1] = selectedList
        mainList.addList(selectedList, listDetail: [])
        
        if selectedIngredient.isEmpty == false {
            mainList.lists[selectedList]!.append(selectedIngredient)
        } else {
            mainList.lists[selectedList]! += selectedIngredients
        }
        print(mainList.lists)
        
        // We only needed the textField so write the label name. Now let's hide the field.
        textField.hidden = true
        textField.text = nil
        textField.alpha = 0.0
        newListText.hidden = true
        newListText.alpha = 0.0
        
        // Set button with list name text.
        newListButton.enabled = true
        newListButton.hidden = false
        
        print(newListButton.titleLabel)
        
        // We just added a new list so let's save.
        PersistManager.sharedManager.ShoppingLists.lists[selectedList] = mainList.lists[selectedList]
        print(PersistManager.sharedManager.ShoppingLists.lists[textField.text!])
        save()
        
        performSelector("dismissViewController", withObject: self, afterDelay: 1.5)
        
    }
    
    func dismissViewController() {
        dismissViewControllerAnimated(true, completion: nil)
    }

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
        let selectedListCount = mainList.lists[selectedList]?.count
        print(mainList.lists[selectedList])
        mainList.lists[selectedList]!.append(selectedIngredient)
        
        print(mainList.lists[selectedList])

        PersistManager.sharedManager.ShoppingLists.lists[selectedList] = mainList.lists[selectedList]
        
        // Save lists
        save()
        
        print(PersistManager.sharedManager.ShoppingLists.lists)
        
        //dismissViewControllerAnimated(true, completion: nil)
        
        //Can't do a regular unwind segue because then this whole function is called out of order. Perform the unwind manually so that the above can run.
        
        if previousVC == "FoodsListTableViewController" {
            print("manual unwind to full list")
            self.performSegueWithIdentifier("addToFullList", sender: self)
            //let preVC = self.storyboard?.instantiateViewControllerWithIdentifier(previousVC) as! FoodsListTableViewController
            //self.unwindForSegue(unwindToIngredientList, towardsViewController: preVC)
            
        } else {

            print("manual unwind to new/edit ingredient")
            self.performSegueWithIdentifier("addToListSelected", sender: self)
            
        }

        
        }
    
    @IBAction func cancelAddToList(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func newListTapped(sender: AnyObject) {
        
        newListButton.hidden = true
        
        newListText.text = ""
        newListText.hidden = false
        newListText.returnKeyType = .Done
        newListText.becomeFirstResponder()
        
        newListButton.setTitle("", forState: .Normal)
        
        //newListText.performSelector("becomeFirstResponder", withObject: nil, afterDelay: 0)
        
    
    }

    func save() {
        
        let saveList = PersistenceHandler()
        saveList.save()
        
    }
}
