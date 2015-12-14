//
//  FoodsListTableViewController.swift
//  FridgeApp
//
//  Created by Chase Peers on 9/26/15.
//  Copyright © 2015 Chase Peers. All rights reserved.
//

import UIKit

class FoodsListTableViewController: UITableViewController, UISearchBarDelegate, UISearchDisplayDelegate  {
        
    // MARK: Properties
    
    var ingredients = [[Ingredient]]()
    var filteredIngredients = [[Ingredient]]()
    var ingredientsByArea: IngredientsByLocation?
    var myFridge = FridgeInfo()
    
    let searchController = UISearchController(searchResultsController: nil)
    
    // This didn't work to transfer data from another viewcontroller in the tab bar.
    //let fromFVC: FridgeInfo? = FridgeViewController().MyFridge
    
    let test = ["Area 1 Door", "Area 2 Door", "Area 3 Door", "Area 4 Door"]
    
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

        // Load global variables
        let FTBC = self.tabBarController as! FridgeTabBarController
        
        ingredients = FTBC.Ingredients
        myFridge = FTBC.MyFridge
        
        if let savedIngredients = loadIngredients() {

            ingredients += savedIngredients
            
        } else {

            // Load the sample data.
            sampleIngredients()

        }
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        
        // Populate the list of ingredients per "Area"
        //self.ingredientsByArea.IBLArray
        //ingredientsByArea = IngredientsByLocation.init(Location: test, Ingredients: ingredients)!
        
        //self.tableView.registerClass(FoodsListTableViewCell.classForCoder(), forCellReuseIdentifier: "FoodsListTableViewCell")
        
        self.tableView.scrollToRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0), atScrollPosition: UITableViewScrollPosition.Top, animated: false)
                
        self.tableView.contentOffset = CGPointMake(0,  (self.searchDisplayController?.searchBar.frame.size.height)! - self.tableView.contentOffset.y)
        
        //print(self.ingredientsByArea?.IBLArray[0][0])
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


//    func viewDidAppear() {
//        
//        if (fromFVC != nil) {
//            self.tableView.reloadData()
//        }
//        
//        print("fromFVC doorNames")
//        print(fromFVC?.doorNames)
//        
//    }
    
    
    // MARK: - Search
    
    func filterContentForSearchText(searchText: String, scope: String = "All") {
  filteredCandies = candies.filter { candy in
    return candy.name.lowercaseString.containsString(searchText.lowercaseString)
  }
 
  tableView.reloadData()
}
    
    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        if myFridge.doorNames.count > 1 {
           return myFridge.doorNames.count
        } else {
            return 1
        }

//        if test.count > 1 {
//            return test.count
//        } else {
//            return 1
//        }
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {

        if  myFridge.doorNames.count > 1 {
            return myFridge.doorNames[section]
        } else {
            return nil
        }

//        if  test.count > 1 {
//            return test[section]
//        } else {
//            return nil
//        }
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == self.searchDisplayController!.searchResultsTableView {

            return self.filteredIngredients.count

        } else {
            
            //return self.ingredients.count

        if self.ingredients[section].count != 0 {
                return self.ingredients[section].count
            } else {
                return 0
            }
            
        }

//            if self.ingredientsByArea!.IBLArray[section] != ["Empty"] {
//                return self.ingredientsByArea!.IBLArray[section].count
//            } else {
//                return 0
//            }
//            
//        }
        
        // return ingredients.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "FoodsListTableViewCell"
        
        let cell = self.tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! FoodsListTableViewCell
            
        
        // Fetches the appropriate meal for the data source layout.
            //let ingredient = ingredients[indexPath.row]
        
        let ingredient : Ingredient
        // var ingredientList = [Ingredient]()
        
            if tableView == self.searchDisplayController!.searchResultsTableView {
                print(indexPath.section)
                print(indexPath.row)
                ingredient = filteredIngredients[indexPath.section][indexPath.row]
            } else {
                ingredient = ingredients[indexPath.section][indexPath.row]
//                for ingredientcounter in 0 ... ingredients.count - 1 {
//                    if ingredients[ingredientcounter].location == test[indexPath.section] {
//                        ingredientList.append(ingredients[ingredientcounter])
//
//                    }
//
//                }
                    
        
        }
        
//            if tableView == self.searchDisplayController!.searchResultsTableView {
//                ingredient = filteredIngredients[indexPath.row]
//            } else {
//                ingredient = ingredients[indexPath.row]
//            }
//        
            //if cell.FoodName.text != nil {
            cell.FoodName?.text = ingredient.name
            //} else {
                //cell.FoodName?.text = ingredient.name
            //}
            
            //if cell.FoodWeight.text == nil {
            //    cell.FoodWeight.text = "Blank"
            //} else {
            cell.FoodWeight?.text = String(ingredient.amount)
            //}
            
            //if cell.FoodExpiry.text == nil {
            //    cell.FoodExpiry.text = "Blank"
            //} else {
            cell.FoodExpiry?.text = ingredient.expiry
            //}
            
            cell.FoodImageView?.image = ingredient.image

            return cell
        
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == .Delete {
            // Delete the row from the data source
            ingredients[indexPath.section].removeAtIndex(indexPath.row)
            
            // Save after removing row
            saveIngredients()
            
            // Remove visually
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */
    
    

    // MARK: Search
    
    func filterContentForSearchText(searchText: String) {
        //var ingredient : Ingredient
        
        // Filter the array using the filter method
        self.filteredIngredients = self.ingredients.filter({( ingredient : [Ingredient]) -> Bool in
            print("Searching")
            for x in 0...ingredient.count - 1 {
                // let categoryMatch = (scope == "All") || (ingredient.category == scope)
                let stringMatch = ingredient[x].name.rangeOfString(searchText)
                // return categoryMatch && (stringMatch != nil)
                return (stringMatch != nil)
            }
            
            return false
        
        })
        
    }
    
    func filterContentForSearchText(searchText: String, scope: String = "All") {
  filteredIngredients = ingredients.filter { ingredient in
    return ingredient.name.lowercaseString.containsString(searchText.lowercaseString)
  }
 
  tableView.reloadData()
}
    
    func searchDisplayController(controller: UISearchDisplayController!, shouldReloadTableForSearchString searchString: String!) -> Bool {
        self.filterContentForSearchText(searchString)
        return true
    }
    
    func searchDisplayController(controller: UISearchDisplayController!, shouldReloadTableForSearchScope searchOption: Int) -> Bool {
        self.filterContentForSearchText(self.searchDisplayController!.searchBar.text!)
        return true
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "EditIngredient" {
            let ingredientDetailViewController = segue.destinationViewController as! NewIngredientViewController
            
            // Is search the sender?
            if self.searchDisplayController!.active {
                print("Will show ingredient from search")
                let indexPath = self.searchDisplayController!.searchResultsTableView.indexPathForSelectedRow!
                let selectedIngredient = self.filteredIngredients[indexPath.section][indexPath.row]
                ingredientDetailViewController.ingredient = selectedIngredient
                print("From Search")

            } else {
            
                // Which cell is the sender?
                if let selectedIngredientCell = sender as? FoodsListTableViewCell {
                let indexPath = tableView.indexPathForCell(selectedIngredientCell)!
                let sectionPath = tableView.indexPathForSelectedRow
                sectionPath?.section
                    
                
                    
                let selectedIngredient = ingredients[indexPath.section][indexPath.row]
                ingredientDetailViewController.ingredient = selectedIngredient
                print("Edit ingredient")
                                
                }
            }
        
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
                    let newRow = self.ingredients[newSection!].count
                    
                    let newIndexPath = NSIndexPath(forRow: self.ingredients[newSection!].count, inSection: newSection!)
                    ingredients[newSection!].append(ingredient)
                    tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
                    
                } else {
                    tableView.reloadRowsAtIndexPaths([selectedIndexPath], withRowAnimation: .None)
                    tableView.reloadData()
                }
                
            } else {

                // Add a new ingredient.
                //let section = test.indexOf(ingredient.location)
                let section = myFridge.doorNames.indexOf(ingredient.location)
                print("section")
                print(section)
                
                let newRow = self.ingredients[section!].count
                print("newRow")
                print(newRow)

                //let ingredientAsArray = [ingredient]
                
                let newIndexPath = NSIndexPath(forRow: self.ingredients[section!].count, inSection: section!)
                ingredients[section!].append(ingredient)
                tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)

            }
            
            // Save ingredients
            saveIngredients()
            
        }
        
    }
    
    // MARK: NSCoding
    func saveIngredients() {
        
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(ingredients, toFile: Ingredient.ArchiveURL.path!)
        
        let FTBC = self.tabBarController as! FridgeTabBarController
        FTBC.MyFridge = myFridge
        
        if !isSuccessfulSave {
            print("Couldn't save")
        }
        
    }
    
    func loadIngredients() -> [[Ingredient]]? {
        
        return NSKeyedUnarchiver.unarchiveObjectWithFile(Ingredient.ArchiveURL.path!) as? [[Ingredient]]
        
    }

}

extension MasterViewController: UISearchBarDelegate {
  // MARK: - UISearchBar Delegate
  func searchBar(searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
    filterContentForSearchText(searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
  }
}

extension MasterViewController: UISearchResultsUpdating {
  // MARK: - UISearchResultsUpdating Delegate
  func updateSearchResultsForSearchController(searchController: UISearchController) {
    let searchBar = searchController.searchBar
    let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
    filterContentForSearchText(searchController.searchBar.text!, scope: scope)
  }
}
