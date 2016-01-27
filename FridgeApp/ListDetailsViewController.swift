//
//  ListDetailsViewController.swift
//  FridgeApp
//
//  Created by Chase Peers on 12/21/15.
//  Copyright © 2015 Chase Peers. All rights reserved.
//

import UIKit

class ListDetailsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var listTableView: UITableView!
    @IBOutlet weak var addExistingButton: UIButton!
    @IBOutlet weak var addNewButton: UIButton!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var finishedShopping: UIBarButtonItem!
    
    var listName: String?
    //var listDetailsDic: [String]?
    var listDetails: [String] = []
    
    var selectedFromList = [""]
    
    var existingIngredients = PersistManager.sharedManager.Ingredients
    
    override func viewDidLoad() {
        super.viewDidLoad()

        listTableView.delegate = self
        listTableView.dataSource = self
        
        print(listName)
        //print(listDetailsDic)
        
        selectedFromList.removeFirst()
        
        
//        if listDetailsDic != nil {
//            
//        for dictCounter in 1...listDetailsDic!.count {
//            listDetails.append(listDetailsDic![dictCounter]!)
//        }
//
//        }
        
        print(listDetails)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - TableView
    */
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
        
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return nil
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.listDetails.count
        
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // the cells you would like the actions to appear needs to be editable
        return true
    }
    
    // Override to support editing the table view.
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == .Delete {
             
            // Delete the row from the data source
            //ingredients[indexPath.section].removeAtIndex(indexPath.row)
            print("delete")

            // Remove from the actual list
            //listDetailsDic?.removeAtIndex(indexPath.row)
            //listDetailsDic.removeValueForKey(listDetails(indexPath.row))

            // Now emove from the "list"
            self.listDetails.removeAtIndex(indexPath.row)

            // Copy list to singleton
            PersistManager.sharedManager.ShoppingLists.lists[listName!] = listDetails

            // Save lists
            let saveList = PersistenceHandler()
            saveList.save()
            
            // Remove visually
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            
            tableView.reloadData()

        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "ListDetailsTableViewCell"
        
        let cell = self.listTableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! ListDetailsTableViewCell
        
        // Fetches the appropriate meal for the data source layout.
        let listIngredient = listDetails[indexPath.row]
        let rowNumber = indexPath.row + 1
        cell.listItemNumber.text = String(rowNumber)
        print(listIngredient)
        cell.listItemName.text = listIngredient
        
        let emptyCircle = UIImage(named: "Unselected")
        let filledCircle = UIImage(named: "Selected")
        
        cell.selectedButton.setImage(emptyCircle, forState: .Normal)
        cell.selectedButton.setImage(filledCircle, forState: .Selected)
        cell.selectedButton.setImage(filledCircle, forState: [.Highlighted,.Selected])
        
        cell.selectedButton.adjustsImageWhenHighlighted = false
        
        if finishedShopping.title == "Finished Shopping" {
            cell.selectedButton.hidden = true
        } else {
            cell.selectedButton.hidden = false
        }
        
        return cell
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func cancelAction(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
        
    @IBAction func unwindToListDetails(sender: UIStoryboardSegue) {
        
        if let listDetailAddExistingIngredient = sender.sourceViewController as? ListDetailAddExistingIngredient {
            
            let selectedIngredients = listDetailAddExistingIngredient.selectedIngredients
            
            print("unwind add to list")
            print(selectedIngredients)
            
            print(listDetails)
            
            listDetails += selectedIngredients
            
            print(listDetails)

            //listName
            
            //let selectedListCount = listDetailsDic!.count
            let selectedListCount = listDetails.count
            
//            for count in 1...selectedIngredients.count {
//                listDetailsDic![count + selectedListCount] = selectedIngredients[count - 1]
//                
//            }
            
            print(listDetails)
            
            PersistManager.sharedManager.ShoppingLists.lists[listName!] = listDetails
            
            // Save lists
            let saveList = PersistenceHandler()
            saveList.save()
            
            listTableView.reloadData()
        
        }
        
    }

    // MARK: - Add List to Fridge
    @IBAction func finishedShoppingTapped(sender: UIBarButtonItem) {
        
        if finishedShopping.title == "Finished Shopping" {
            finishedShopping.title = "Add Selected"
            listTableView.reloadData()
        } else {
            
            var ingredients = PersistManager.sharedManager.Ingredients
            var ingredientsToBeAdded = [Ingredient]()
            
            for ingredient in 0...selectedFromList.count - 1 {
                let addIngredient = [Ingredient(name: selectedFromList[ingredient], image: nil, expiry: "", amount: 0.0, location: "Area 1 Door")!]
                ingredientsToBeAdded += addIngredient
            }
            
            if ingredientsToBeAdded.count > 0 {
                ingredients[0] += ingredientsToBeAdded
            }
            
            PersistManager.sharedManager.Ingredients = ingredients
            
            let saveIngredients = PersistenceHandler()
            saveIngredients.save()
            
            
            
        }
    
    }
    
    @IBAction func wasSelected(sender: AnyObject) {
        
        //if selectedIngredients.count < 1 {
        //    addSelected.enabled = false
        //} else {
        //    addSelected.enabled = true
        //}
        
        let button = sender as! UIButton
        let cell = button.superview?.superview as! ListDetailsTableViewCell
        let sectionAndRow = listTableView.indexPathForCell(cell)
        let row = sectionAndRow?.row
        
        print(row)
        print(button.selected)
        
        let name = listDetails[row!]
        
        if button.selected == true {
            button.selected = false
            if selectedFromList.contains(name) == true {
                let index = selectedFromList.indexOf(name)
                selectedFromList.removeAtIndex(index!)
            }
            print(selectedFromList)
        } else {
            button.selected = true
            selectedFromList.append(name)
            print(selectedFromList)
        }
        
    }

    
    // MARK: - Share Menu
    @IBAction func shareButtonTapped(sender: UIBarButtonItem) {
        
        let objectsToShare = [listDetails]
        let activityVC = UIActivityViewController(activityItems: objectsToShare as [AnyObject], applicationActivities: nil)
            
        //New Excluded Activities Code
        activityVC.excludedActivityTypes = [UIActivityTypeAirDrop, UIActivityTypeAddToReadingList]

        self.presentViewController(activityVC, animated: true, completion: nil)
        
    }
}
