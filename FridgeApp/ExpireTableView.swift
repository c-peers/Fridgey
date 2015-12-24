//
//  ExpireTableView.swift
//  FridgeApp
//
//  Created by Chase Peers on 12/14/15.
//  Copyright © 2015 Chase Peers. All rights reserved.
//

import UIKit

class ExpireTableView: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var expiryTableView: UITableView!
    @IBOutlet weak var navbarTitleText: UILabel!
    
    // MARK: Properties
    
    var ingredients = [[Ingredient]]()
    var filteredIngredients = [[Ingredient]]()
    var expiredIngredients = [[Ingredient]]()
    var myFridge = FridgeInfo()
    var withinExpiryTime: Int = 14
    
    //let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        // Load any saved Ingredients, otherwise load sample data.
        
        expiryTableView.delegate = self
        expiryTableView.dataSource = self
        
        // Load global variables
        let FTBC = self.tabBarController as! FridgeTabBarController
        
        ingredients = FTBC.Ingredients
        myFridge = FTBC.MyFridge
        
        if let savedIngredients = loadIngredients() {
            
            ingredients += savedIngredients
            
        }
        
        expiredIngredients = ingredients
        
        // We will only show dates in the range set in the view controller.
        let date = NSDate()
        let dateFormatter = NSDateFormatter()
        
        var dateAsString: String
        
        dateFormatter.dateFormat = "YYYY-MM-dd"
        dateAsString = "2015-12-19"
        let cellExpiryDate = dateFormatter.dateFromString(dateAsString)!
        dateAsString = dateFormatter.stringFromDate(date)
        let currentDate = dateFormatter.dateFromString(dateAsString)!
        let currentDatePlusExpiryWindow = NSCalendar.currentCalendar().dateByAddingUnit(NSCalendarUnit.Day, value: withinExpiryTime, toDate: currentDate, options: NSCalendarOptions.init(rawValue: 0))
        
        var calculatedDate = NSCalendar.currentCalendar().dateByAddingUnit(NSCalendarUnit.Day, value: 20, toDate: cellExpiryDate, options: NSCalendarOptions.init(rawValue: 0))
        
        var diffDateComponents = NSCalendar.currentCalendar().components([NSCalendarUnit.Year, NSCalendarUnit.Month, NSCalendarUnit.Day, NSCalendarUnit.Hour, NSCalendarUnit.Minute, NSCalendarUnit.Second], fromDate: cellExpiryDate, toDate: currentDate, options: NSCalendarOptions.init(rawValue: 0))
        
        //Go through the original ingredient array and the copy. Remove all ingredients that aren't close to the set expiration date.
        for x in 0...ingredients.count - 1 {
            
            var arrayYValue = 0
            
            print("x")
            print(x)
            
            for y in 0...ingredients[x].count - 1 {
                
                print("y")
                print(y)
                
                print("Ingredient.expiration")
                print(ingredients[x][y].expiry)
                
                dateAsString = ingredients[x][y].expiry
                let cellExpiryDate = dateFormatter.dateFromString(dateAsString)!
                diffDateComponents = NSCalendar.currentCalendar().components([NSCalendarUnit.Year, NSCalendarUnit.Month, NSCalendarUnit.Day, NSCalendarUnit.Hour, NSCalendarUnit.Minute, NSCalendarUnit.Second], fromDate: cellExpiryDate, toDate: currentDate, options: NSCalendarOptions.init(rawValue: 0))
                
                // Only remove if the expiration date is greater than the current date + offset
                if cellExpiryDate.laterDate(currentDatePlusExpiryWindow!) == cellExpiryDate {
                    
                    //let appendIngredientToExpiryArr = ingredients[x][arrayYValue]
                    
                    print("exp ingred")
                    print(expiredIngredients)
                    
                    //Use arrayYValue because the indexes will change after removing a value.
                    expiredIngredients[x].removeAtIndex(arrayYValue)
                    
                } else {
                    // This index is fine so increment the counter
                    print("no match")
                    arrayYValue += 1
                }
                
            }
            
        }
        
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
        
        // Populate the list of ingredients per "Area"
        //self.ingredientsByArea.IBLArray
        //ingredientsByArea = IngredientsByLocation.init(Location: test, Ingredients: ingredients)!
        
        //self.tableView.registerClass(FoodsListTableViewCell.classForCoder(), forCellReuseIdentifier: "FoodsListTableViewCell")
        
        self.expiryTableView.scrollToRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0), atScrollPosition: UITableViewScrollPosition.Top, animated: false)
        
        //self.tableView.contentOffset = CGPointMake(0,  (self.searchDisplayController?.searchBar.frame.size.height)! - self.tableView.contentOffset.y)
        
        //print(self.ingredientsByArea?.IBLArray[0][0])
        
        //NSNotificationCenter.defaultCenter().addObserver(self, selector: "loadList:",name:"load", object: nil)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func viewDidAppear() {
        
        print("didappear")
        self.expiryTableView.reloadData()
        
    }
        
    @IBAction func navbarTitleWasTapped(recognizer:UITapGestureRecognizer) {
        print("tap!")
    }
    
    
    // MARK: - Search
    
    //    func filterContentForSearchText(searchText: String, scope: String = "All") {
    //  filteredCandies = candies.filter { candy in
    //    return candy.name.lowercaseString.containsString(searchText.lowercaseString)
    //  }
    //
    //  tableView.reloadData()
    //}
    
    
    // MARK: - Table view data source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
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
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
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
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //if tableView == self.searchDisplayController!.searchResultsTableView {
        
        //    return self.filteredIngredients.count
        
        //} else {
        
        //return self.ingredients.count
        
        if self.ingredients[section].count != 0 {
            return self.expiredIngredients[section].count
        } else {
            return 0
        }
        
        //}
        
        //            if self.ingredientsByArea!.IBLArray[section] != ["Empty"] {
        //                return self.ingredientsByArea!.IBLArray[section].count
        //            } else {
        //                return 0
        //            }
        //
        //        }
        
        // return ingredients.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "ExpirationListTableViewCell"
        
        let cell = self.expiryTableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! ExpireTableViewCell
        
        
        // Fetches the appropriate meal for the data source layout.
        let ingredient : Ingredient
        // var ingredientList = [Ingredient]()
        
        //            if tableView == self.searchDisplayController!.searchResultsTableView {
        //                print(indexPath.section)
        //                print(indexPath.row)
        //                ingredient = filteredIngredients[indexPath.section][indexPath.row]
        //            } else {
        ingredient = expiredIngredients[indexPath.section][indexPath.row]
        //                for ingredientcounter in 0 ... ingredients.count - 1 {
        //                    if ingredients[ingredientcounter].location == test[indexPath.section] {
        //                        ingredientList.append(ingredients[ingredientcounter])
        //
        //                    }
        //
        //                }
        
        
        //}
        
        //            if tableView == self.searchDisplayController!.searchResultsTableView {
        //                ingredient = filteredIngredients[indexPath.row]
        //            } else {
        //                ingredient = ingredients[indexPath.row]
        //            }
        //

        cell.expireFoodName?.text = ingredient.name
        cell.expireFoodAmount?.text = String(ingredient.amount)
        cell.expireFoodDate?.text = ingredient.expiry
        cell.expireFoodImage?.image = ingredient.image
        
        return cell
        
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
    
    func loadIngredients() -> [[Ingredient]]? {
        
        return NSKeyedUnarchiver.unarchiveObjectWithFile(Ingredient.ArchiveURL.path!) as? [[Ingredient]]
        
    }
    
}
