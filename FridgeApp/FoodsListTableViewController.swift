//
//  FoodsListTableViewController.swift
//  FridgeApp
//
//  Created by Chase Peers on 9/26/15.
//  Copyright © 2015 Chase Peers. All rights reserved.
//

import UIKit

class FoodsListTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchResultsUpdating, TabBarDelegate, MGSwipeTableCellDelegate {
        
    @IBOutlet weak var tableView: UITableView!
    //@IBOutlet weak var editButton: UIBarButtonItem!
    @IBOutlet weak var listAddedText: UILabel!
    @IBOutlet weak var listAddedView: UIView!

    // MARK: Properties
    
    var ingredients = [[Ingredient]]()
    var ingredientNames = [[""]]
    var filteredIngredients = [[Ingredient]]()
    var myFridge = FridgeInfo()
    var mainList = Lists()
    
    var selectedIngredient = ""
    
    let searchController = UISearchController(searchResultsController: nil)
    var filteredData = [""]
    
    // Temporary Sample
    func sampleIngredients() {
        
        //let photo1 = UIImage(named: "meal1")!
        let ingredient1 = [Ingredient(name: "Carrot", image: UIImage(named: "blank"), expiry: "2015-10-4", amount: 400.0, location: "Area 1 Door")!]
        ingredients.append(ingredient1)
        
        //let photo2 = UIImage(named: "meal2")!
        let ingredient2 = [Ingredient(name: "Eggs", image: UIImage(named: "blank"), expiry: "2015-10-2", amount: 6.0, location: "Area 2 Door")!]
        ingredients.append(ingredient2)
        
        //let photo3 = UIImage(named: "meal3")!
        let ingredient3 = [Ingredient(name: "Ice Cream", image: UIImage(named: "blank"), expiry: "2016-4-29", amount: 10.0, location: "Area 3 Door")!]
        ingredients.append(ingredient3)

        //let photo3 = UIImage(named: "meal3")!
        let ingredient4 = [Ingredient(name: "Potato", image: UIImage(named: "blank"), expiry: "2015-10-8", amount: 850.0, location: "Area 4 Door")!]
        ingredients.append(ingredient4)

        // ingredients += [ingredient1, ingredient2, ingredient3, ingredient4]
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        // Load any saved Ingredients, otherwise load sample data.
        
        listAddedView.alpha = 0.0
        
        tableView.delegate = self
        tableView.dataSource = self

        let loadSingleton = PersistenceHandler()
        loadSingleton.load("Ingredients")
        
        ingredients = PersistManager.sharedManager.Ingredients
        myFridge = PersistManager.sharedManager.MyFridge
        mainList = PersistManager.sharedManager.ShoppingLists
        
        print("d00r")
        print(myFridge.doorNames)
        
//        if let savedFridge = PersistManager.sharedManager.loadFridge() {
//            
//            myFridge = savedFridge
//            //saveToFTBC.MyFridge = savedFridge
//            
//            print("Saved Fridge")
//            print(myFridge.numOfDoors)
//            print(myFridge.doorNames)
//            print(myFridge.fridgeName)
//            
//        }
        
//        if let savedIngredients = PersistManager.sharedManager.loadIngredients() {
//
//            ingredients += savedIngredients
//            
//        } else {
//
            // Load the sample data.
            //sampleIngredients()

        //}
        
        if let savedLists = PersistManager.sharedManager.loadList() {
            print("lists loaded")
            mainList = savedLists
            
        }
        
        // I'm having trouble with searching through my ingredients so I made a 2d array with just the ingredient names.
        
        // Remove the [""]
        ingredientNames.removeAll()
        
        for x in 0...ingredients.count - 1 {
            
            for y in 0...ingredients[x].count - 1 {
                
                if y == 0 {
                    ingredientNames.append([ingredients[x][y].name])
                } else {
                    ingredientNames[x].append(ingredients[x][y].name)
                }
                
            }
         
        }
        
        print(ingredientNames)
        
        print("flatten")
        print(Array(ingredientNames.flatten()))
        
        searchController.searchResultsUpdater = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.sizeToFit()
        self.tableView.tableHeaderView = searchController.searchBar
        
        // Initializing with searchResultsController set to nil means that
        // searchController will use this view controller to display the search results
        //searchController.searchResultsUpdater = self
        
        // If we are using this same view controller to present the results
        // dimming it out wouldn't make sense.  Should set probably only set
        // this to yes if using another controller to display the search results.
        //searchController.dimsBackgroundDuringPresentation = false

        //searchController.searchBar.sizeToFit()
        //tableView.tableHeaderView = searchController.searchBar

        // Sets this view controller as presenting view controller for the search interface
        //definesPresentationContext = true
        
        //self.tableView.registerClass(FoodsListTableViewCell.classForCoder(), forCellReuseIdentifier: "FoodsListTableViewCell")
        
        self.tableView.scrollToRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0), atScrollPosition: UITableViewScrollPosition.Top, animated: false)
                
        //self.tableView.contentOffset = CGPointMake(0,  (self.searchDisplayController?.searchBar.frame.size.height)! - self.tableView.contentOffset.y)
        
        //self.tableView.allowsMultipleSelectionDuringEditing = true
        //self.tableView.allowsSelectionDuringEditing = true
        
        navigationItem.leftBarButtonItem = editButtonItem()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "loadList:",name:"load", object: nil)
        
    }
    
    func loadList(notification: NSNotification){
        //load data here
        print("It actually ran?")
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func viewWillAppear() {
        ingredients = PersistManager.sharedManager.Ingredients
        myFridge = PersistManager.sharedManager.MyFridge
        mainList = PersistManager.sharedManager.ShoppingLists

        print("VWA")
        //print(ingredients)
        //print(myFridge.doorNames)
        //print(mainList.lists)
    }
    

    func viewDidAppear() {
        
        print("didappear")
        self.tableView.reloadData()
        
    }
    
    func didSelectTab(tabBarController: FridgeTabBarController) {
        ingredients = PersistManager.sharedManager.Ingredients
        myFridge = PersistManager.sharedManager.MyFridge
        mainList = PersistManager.sharedManager.ShoppingLists
        
        //print(PersistManager.sharedManager.Ingredients)
        
        print("Actually reload??")
        self.tableView.reloadData()
        
    }
    
    // MARK: - Search
    
//    func filterContentForSearchText(searchText: String, scope: String = "All") {
//  filteredCandies = candies.filter { candy in
//    return candy.name.lowercaseString.containsString(searchText.lowercaseString)
//  }
// 
//  tableView.reloadData()
//}
   
    func updateSearchResultsForSearchController(searchController: UISearchController) {
     
        //if searchController.searchBar.text?.characters.count > 0 {
            
            filteredData.removeAll(keepCapacity: false)
            //filteredData = ingredientNames.flatten().filter({$0 == searchController.searchBar.text!})
//            filteredData = ingredients.filter({ ingredient in
//                return ingredient.name.lowercaseString.containsString(searchController.searchBar.text!)
//            })
//            for section in 0...ingredients.count - 1 {
//                filteredData = ingredients[section].filter({ ingredient in
//                    return ingredient.name.lowercaseString.containsString(searchController.searchBar.text!) })
//            }
//            self.tableView.reloadData()
//            
//            filteredCandies = candies.filter { candy in
//                return candy.name.lowercaseString.containsString(searchText.lowercaseString)
//            }
//            
//            print(filteredData)
//
//        } else {
//            
//            filteredData.removeAll(keepCapacity: false)
//            filteredData = Array(ingredientNames.flatten())
//            tableView.reloadData()
//        }
        
        //let searchPredicate = NSPredicate(format: "SELF CONTAINS[c] %@", searchController.searchBar.text!)
        
        
        //filteredData = ingredients.flatten().filter({$0 == searchController.searchBar.text!})
        
        //let array = (ingredients[0] as NSArray).filteredArrayUsingPredicate(searchPredicate)
        //filteredData = array as! [String]
        
        
        
    }
    
//    @IBAction func editTapped(sender: UIBarButtonItem) {
//        //self.tableView.editing = !self.tableView.editing
//        tableView.editing = !tableView.editing
//
//        if self.tableView.editing == true {
//            print("coming here?")
//            self.editButton.title = "Done"
//        } else {
//            self.editButton.title = "Edit"
//        }
//    }
//    
    // MARK: MGSwipe
    
    func swipeTableCell(cell: MGSwipeTableCell!, canSwipe direction: MGSwipeDirection) -> Bool {
        return true
    }
    
    func swipeTableCell(cell: MGSwipeTableCell!, didChangeSwipeState state: MGSwipeState, gestureIsActive: Bool) {
        
    }
    
    func swipeTableCell(cell: MGSwipeTableCell!, tappedButtonAtIndex index: Int, direction: MGSwipeDirection, fromExpansion: Bool) -> Bool {
        
        let indexPath = tableView.indexPathForCell(cell)
        let ingredient = ingredients[indexPath!.section][indexPath!.row]
        
        if (direction == MGSwipeDirection.RightToLeft && index == 0) {
            
            print("deleting from MGSwipe")
            
            // Delete the row from the data source
            ingredients[indexPath!.section].removeAtIndex(indexPath!.row)
            
            // Save after removing row
            //PersistManager.sharedManager.saveIngredients()
            PersistManager.sharedManager.Ingredients = ingredients
            
            let saveSingleton = PersistenceHandler()
            saveSingleton.save()
            
            // Remove visually
            tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: .Fade)
            
        }
        
        if (direction == MGSwipeDirection.LeftToRight && index == 0) {
            
            print("add to list from ingredients table")
            selectedIngredient = ingredient.name
            
            let controller = self.storyboard?.instantiateViewControllerWithIdentifier("AddToListFromIngredientTab") as! AddToListFromIngredientDetailsViewController
            controller.previousVC = "FoodsListTableViewController"
            controller.selectedIngredient = ingredient.name
            self.presentViewController(controller, animated: true, completion: nil)
            
        }
        
        return true
        
    }
    
    // MARK: - Table view data source

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        if myFridge.doorNames.count > 1 {
           return myFridge.doorNames.count
        } else {
            return 1
        }

    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {

        if  myFridge.doorNames.count > 1 {
            return myFridge.doorNames[section]
        } else {
            return nil
        }

    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //if tableView == self.searchDisplayController!.searchResultsTableView {

        //    return self.filteredIngredients.count

        //} else {
            
            //return self.ingredients.count

        if self.ingredients[section].count != 0 {
                return self.ingredients[section].count
            } else {
                return 0
            }
            
        //}

//
//        }
        
        // return ingredients.count
    }
    
//    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
//        
//        let delete = UITableViewRowAction(style: .Normal, title: "Delete") { action, index in print("button was tapped")
//        }
//        
//        delete.backgroundColor = UIColor.redColor()
//        
//        let addToList = UITableViewRowAction(style: .Normal, title: "Add to List") { action, index in print("add to list button")
//        }
//        //let addToList = UITableViewRowAction(style: .Normal, title: "Add to List", handler: <#T##(UITableViewRowAction, NSIndexPath) -> Void#>)
//        
//        addToList.backgroundColor = UIColor.blueColor()
//        
//        return [delete, addToList]
//    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // the cells you would like the actions to appear needs to be editable
        return true
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "FoodsListTableViewCell"
        
        let cell = self.tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! FoodsListTableViewCell
        
        //if cell == nil
        //{
        //    cell = MGSwipeTableCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: reuseIdentifier)
        //}
        
        // Fetches the appropriate meal for the data source layout.
            //let ingredient = ingredients[indexPath.row]
        
        let ingredient : Ingredient

        //if searchController.active {
        //    cell.textLabel?.text = filteredData[indexPath.row]
        //}
        //else {
        
//            if tableView == self.searchDisplayController!.searchResultsTableView {
//                print(indexPath.section)
//                print(indexPath.row)
//                ingredient = filteredIngredients[indexPath.section][indexPath.row]
//            } else {

//            if tableView == self.searchDisplayController!.searchResultsTableView {
//                ingredient = filteredIngredients[indexPath.row]
//            } else {
//                ingredient = ingredients[indexPath.row]
//            }
//

            ingredient = ingredients[indexPath.section][indexPath.row]

            
        cell.FoodName?.text = ingredient.name
        cell.FoodExpiry?.text = ingredient.expiry
        cell.FoodImageView?.image = ingredient.image

        if ingredient.amount == 0.0 {
            cell.FoodAmount?.text = ""
        } else {
            cell.FoodAmount?.text = String(ingredient.amount)
        }
        
        cell.leftButtons = [MGSwipeButton(title: "Add to List", icon: UIImage(named:"Add"), backgroundColor: UIColor.blueColor())]
        cell.leftSwipeSettings.transition = MGSwipeTransition.Border
        
        //configure right buttons
        cell.rightButtons = [MGSwipeButton(title: "Delete", icon: UIImage(named:"Trash"), backgroundColor: UIColor.redColor())]
        //cell.rightButtons = [MGSwipeButton(title: "Delete", backgroundColor: UIColor.redColor())]
        //cell.rightButtons = [MGSwipeButton(title: "Delete", backgroundColor: UIColor.redColor())
        //    ,MGSwipeButton(title: "Add To List",backgroundColor: UIColor.blueColor())]
        cell.rightSwipeSettings.transition = MGSwipeTransition.ClipCenter
        
        cell.leftExpansion.buttonIndex = 2
        cell.leftExpansion.fillOnTrigger = true
        cell.leftExpansion.buttonIndex = 0
        cell.leftExpansion.expansionColor = UIColor.blueColor()
        
        cell.rightExpansion.buttonIndex = 2
        cell.rightExpansion.fillOnTrigger = true
        cell.rightExpansion.buttonIndex = 0
        cell.rightExpansion.expansionColor = UIColor.redColor()
        
        
        
        cell.delegate = self
        
//        let deleteButton = MGSwipeButton(title: "Delete", backgroundColor: UIColor.redColor(), callback: {( sender: MGSwipeTableCell!) -> Void in
//            self.ingredients[indexPath.section].removeAtIndex(indexPath.row)
//            
//            // Save after removing row
//            //PersistManager.sharedManager.saveIngredients()
//            PersistManager.sharedManager.Ingredients = self.ingredients
//            
//            let saveSingleton = PersistenceHandler()
//            saveSingleton.save()
//            
//            // Remove visually
//            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
//            })
        
        //}
            
        return cell
        
    }
    
    func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        
        print("how about here?")
        
        if (!self.tableView.editing) {
            print("called??")
            return .Delete
        } else {
            return .None
        }
        
    }
    
    // Override to support editing the table view.
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == .Delete {
            // Delete the row from the data source
            ingredients[indexPath.section].removeAtIndex(indexPath.row)
            
            // Save after removing row
            //PersistManager.sharedManager.saveIngredients()
            PersistManager.sharedManager.Ingredients = ingredients
            
            let saveSingleton = PersistenceHandler()
            saveSingleton.save()
            
            // Remove visually
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    
    // Override to support rearranging the table view.
    func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

        let moveThisItem = ingredients[fromIndexPath.section][fromIndexPath.row]
        ingredients[fromIndexPath.section].removeAtIndex(fromIndexPath.row)
        ingredients[toIndexPath.section].append(moveThisItem)
        
        // Save after removing row
        //PersistManager.sharedManager.saveIngredients()
        PersistManager.sharedManager.Ingredients = ingredients
        
        let saveSingleton = PersistenceHandler()
        saveSingleton.save()
        
    }
    

    
    // Override to support conditional rearranging of the table view.
    func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }

    // MARK: Search
    
//    func filterContentForSearchText(searchText: String) {
//        //var ingredient : Ingredient
//        
//        // Filter the array using the filter method
//        self.filteredIngredients = self.ingredients.filter({( ingredient : [Ingredient]) -> Bool in
//            print("Searching")
//            for x in 0...ingredient.count - 1 {
//                // let categoryMatch = (scope == "All") || (ingredient.category == scope)
//                let stringMatch = ingredient[x].name.rangeOfString(searchText)
//                // return categoryMatch && (stringMatch != nil)
//                return (stringMatch != nil)
//            }
//            
//            return false
//        
//        })
//        
//    }
    
//    func updateSearchResultsForSearchController(searchController: UISearchController) {
//        let searchText = searchController.searchBar.text
//
//        filteredData = searchText.isEmpty ? ingredient : ingredient.filter({(ingredientString: String) -> Bool in
//            return ingredientString.rangeOfString(searchText, options: .CaseInsensitiveSearch) != nil
//        })
//
//        tableView.reloadData()
//    }
//
//    func filterContentForSearchText(searchText: String, scope: String = "All") {
//  filteredIngredients = ingredients.filter { ingredient in
//    return ingredient.name.lowercaseString.containsString(searchText.lowercaseString)
//  }
// 
//  tableView.reloadData()
//}
    
//    func searchDisplayController(controller: UISearchDisplayController!, shouldReloadTableForSearchString searchString: String!) -> Bool {
//        self.filterContentForSearchText(searchString)
//        return true
//    }
//    
//    func searchDisplayController(controller: UISearchDisplayController!, shouldReloadTableForSearchScope searchOption: Int) -> Bool {
//        self.filterContentForSearchText(self.searchDisplayController!.searchBar.text!)
//        return true
//    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        if identifier == "EditIngredient" && self.tableView.editing {
            return false
        }
        
        return true
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

        let ingredientDetailViewController = segue.destinationViewController as! NewIngredientViewController
        
        ingredientDetailViewController.locationPickerData = myFridge.doorNames

        if segue.identifier == "EditIngredient" {
            //let ingredientDetailViewController = segue.destinationViewController as! NewIngredientViewController
            
            // Is search the sender?
//            if self.searchDisplayController!.active {
//                print("Will show ingredient from search")
//                let indexPath = self.searchDisplayController!.searchResultsTableView.indexPathForSelectedRow!
//                let selectedIngredient = self.filteredIngredients[indexPath.section][indexPath.row]
//                ingredientDetailViewController.ingredient = selectedIngredient
//                print("From Search")
//
//            } else {
            
                // Which cell is the sender?
                if let selectedIngredientCell = sender as? FoodsListTableViewCell {
                let indexPath = tableView.indexPathForCell(selectedIngredientCell)!
                let sectionPath = tableView.indexPathForSelectedRow
                sectionPath?.section
                
                
                    
                let selectedIngredient = ingredients[indexPath.section][indexPath.row]
                ingredientDetailViewController.ingredient = selectedIngredient
                ingredientDetailViewController.mainList = mainList
                print("Edit ingredient")
                    
                ingredientDetailViewController.locationPickerData = myFridge.doorNames
                    
                }
            //}
        
        }
        else if segue.identifier == "AddIngredient" {
                print("Add ingredient")
            
        }
        
    }
    
    @IBAction func unwindToIngredientList(sender: UIStoryboardSegue) {
        
        if let sourceViewController = sender.sourceViewController as? NewIngredientViewController, ingredient = sourceViewController.ingredient {
        
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                
                //let ingredientholder: Ingredient
                
                // Refresh an ingredients data
                ingredients[selectedIndexPath.section][selectedIndexPath.row] = ingredient
                if ingredient.location != myFridge.doorNames[selectedIndexPath.section] {
                    
                    ingredients[selectedIndexPath.section].removeAtIndex(selectedIndexPath.row)
                    tableView.deleteRowsAtIndexPaths([selectedIndexPath], withRowAnimation: .None)
                    
                    let newSection = myFridge.doorNames.indexOf(ingredient.location)
                    //let newRow = self.ingredients[newSection!].count
                    
                    let newIndexPath = NSIndexPath(forRow: self.ingredients[newSection!].count, inSection: newSection!)
                    ingredients[newSection!].append(ingredient)
                    tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
                    
                } else {
                    tableView.reloadRowsAtIndexPaths([selectedIndexPath], withRowAnimation: .None)
                    tableView.reloadData()
                }
                
            } else {

                // Add a new ingredient.
                let section = myFridge.doorNames.indexOf(ingredient.location)
                print("section")
                print(section)
                
                let newRow = self.ingredients[section!].count
                print("newRow")
                print(newRow)
                
                let newIndexPath = NSIndexPath(forRow: self.ingredients[section!].count, inSection: section!)
                ingredients[section!].append(ingredient)
                tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
                
            }
            
            // Save ingredients
            //PersistManager.sharedManager.saveIngredients()
            PersistManager.sharedManager.Ingredients = ingredients

            let saveSingleton = PersistenceHandler()
            saveSingleton.save()

            
        }
    
        if let addToListFromIngredientDetailsViewController = sender.sourceViewController as? AddToListFromIngredientDetailsViewController {
            
            let selectedList = addToListFromIngredientDetailsViewController.selectedList

            print("unwind ingredient added")
            print(selectedList)
            
            self.listAddedText.text = selectedIngredient + " added to " + selectedList
            print(listAddedText.text)
            
            self.listAddedView.hidden = false
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(1.5 * Double(NSEC_PER_SEC))), dispatch_get_main_queue()) { () -> Void in
                self.fadeInOut()
            }
            
        }
        
    }
    
    func fadeInOut() {
        
        UIView.animateWithDuration(NSTimeInterval(2.0), delay: 0.0, options: UIViewAnimationOptions.CurveLinear, animations: { self.listAddedView.alpha = 0.8; print("Fade In") }, completion: nil)
        UIView.animateWithDuration(NSTimeInterval(2.0), delay: 1.0, options: UIViewAnimationOptions.CurveLinear, animations: { self.listAddedView.alpha = 0.0; print("Fade Out") }, completion: nil)
        
    }

    //MARK:- Editing toggle
    
    @IBAction func startEditing(sender: UIBarButtonItem) {
        tableView.editing = !tableView.editing
    }
    
    override func setEditing(editing: Bool, animated: Bool) {
        tableView.editing = editing
        super.setEditing(editing, animated: true)
    }

    
}

//extension FoodsListTableViewController: UISearchBarDelegate {
//  // MARK: - UISearchBar Delegate
//  func searchBar(searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
//    filterContentForSearchText(searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
//  }
//}
//
//extension FoodsListTableViewController: UISearchResultsUpdating {
//  // MARK: - UISearchResultsUpdating Delegate
//  func updateSearchResultsForSearchController(searchController: UISearchController) {
//    let searchBar = searchController.searchBar
//    let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
//    filterContentForSearchText(searchController.searchBar.text!, scope: scope)
//  }
//}

