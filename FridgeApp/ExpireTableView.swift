//
//  ExpireTableView.swift
//  FridgeApp
//
//  Created by Chase Peers on 12/14/15.
//  Copyright © 2015 Chase Peers. All rights reserved.
//

import UIKit

class ExpireTableView: UIViewController, UITableViewDataSource, UITableViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource, TabBarDelegate {
    
    @IBOutlet weak var expiryTableView: UITableView!
    @IBOutlet weak var navbarTitleText: UILabel!
    @IBOutlet weak var hiddenTextField: UITextField!
    @IBOutlet weak var changeViewButton: UIButton!
    @IBOutlet weak var trashButton: UIBarButtonItem!
    @IBOutlet weak var addToListButton: UIBarButtonItem!
    
    // MARK: Properties
    
    // Ingredients
    var ingredients = [[Ingredient]]()
    var filteredIngredients = [[Ingredient]]()
    var expiredIngredients = [[Ingredient]]()
    var expiredByDate = [[Ingredient]]()
    
    // Other globals
    var myFridge = FridgeInfo()
    var lists = Lists()
    
    // Picker
    var expirationPickerData = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31]
    var expirationPicker = UIPickerView()
    
    // Expired related
    var expiryDates: [String] = []
    var withinExpiryTime: Int = 14
    var isDateSeparatedTable = false
    
    var selectedIngredients: [String] = []
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Change to Date View")
        refreshControl.addTarget(self, action: "changeTable:", forControlEvents: UIControlEvents.ValueChanged)
        
        return refreshControl
    }()
    
    var navBar = UINavigationBar(frame: CGRect(x: 0, y: 20, width: 0, height: 44))
    var navItem = UINavigationItem(title: "")
    
    //let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the nav bar details
        //navItem = UINavigationItem(title: "Expiring in \(withinExpiryTime) days")
        navItem = UINavigationItem(title: "")
        navbarTitleText.text = "Expiring in \(withinExpiryTime) days"
        navItem.leftBarButtonItem = self.editButtonItem()
        navItem.rightBarButtonItem = self.addToListButton
        
        navBar.frame = CGRectMake(0, 20, view.frame.width, 44)
        self.view.addSubview(navBar)
        
        navBar.addSubview(navbarTitleText)
        
        navBar.setItems([navItem], animated: false)
        
        self.navBar.sendSubviewToBack(self.view)
        navbarTitleText.bringSubviewToFront(self.view)

        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        self.expiryTableView.addSubview(self.refreshControl)
        
        changeViewButton.setTitle("Change View", forState: .Normal)
        
        // Hacky hidden text field so we can tap the nav title to change the expiration window
        hiddenTextField.hidden = true
        hiddenTextField.inputView = expirationPicker
        
        ingredients = PersistManager.sharedManager.Ingredients
        myFridge = PersistManager.sharedManager.MyFridge
        lists = PersistManager.sharedManager.ShoppingLists
        
        expiredIngredients = ingredients
        
        addToListButton.tag = 1
        
        // Connect data:
        expiryTableView.delegate = self
        expiryTableView.dataSource = self
        expirationPicker.delegate = self
        expirationPicker.dataSource = self
        
        
        //calculateExpired()
        //calculateExpiredByDate()
        
        
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
        
        //self.expiryTableView.scrollToRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0), atScrollPosition: UITableViewScrollPosition.Top, animated: false)
        
        //self.tableView.contentOffset = CGPointMake(0,  (self.searchDisplayController?.searchBar.frame.size.height)! - self.tableView.contentOffset.y)
        
        //NSNotificationCenter.defaultCenter().addObserver(self, selector: "loadList:",name:"load", object: nil)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func didSelectTab(tabBarController: FridgeTabBarController) {
        ingredients = PersistManager.sharedManager.Ingredients
        myFridge = PersistManager.sharedManager.MyFridge
        lists = PersistManager.sharedManager.ShoppingLists
        
        calculateExpired()
        
        calculateExpiredByDate()
        
        print("Actually reload??")
        self.expiryTableView.reloadData()
        
    }
    
    
    // MARK: Picker
    @IBAction func navbarTitleWasTapped(recognizer:UITapGestureRecognizer) {
        print("tap!")
        
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.Default
        toolBar.translucent = true
        //toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Plain, target: self, action: "donePicker")
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        let pickerTitle2 = UIBarButtonItem(title: "Choose an expiration window", style: UIBarButtonItemStyle.Plain, target: self, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Plain, target: self, action: "cancelPicker")
        
        toolBar.setItems([cancelButton, pickerTitle2, doneButton], animated: false)
        toolBar.userInteractionEnabled = true
        
        hiddenTextField.inputAccessoryView = toolBar
        
        // Set picker to the location set in the ingredient location value... If it exists.
        
        let setrow = expirationPickerData.indexOf(withinExpiryTime)
        print("setrow")
        print(setrow)
        
        self.expirationPicker.selectRow(setrow!, inComponent: 0, animated: true)
        
        hiddenTextField.becomeFirstResponder()
        
    }
    
    func donePicker() {
        
        withinExpiryTime = expirationPickerData[expirationPicker.selectedRowInComponent(0)]
        navbarTitleText.text = "Expiring within \(withinExpiryTime) days"
        calculateExpired()
        calculateExpiredByDate()
        hiddenTextField.resignFirstResponder()
        self.expiryTableView.reloadInputViews()
        self.expiryTableView.reloadData()
        
    }
    
    func cancelPicker() {
        
        hiddenTextField.resignFirstResponder()
        
    }
    
    @IBAction func hiddenTextDidBeginEditing(sender: AnyObject) {
        print("This one?")
        
        
        hiddenTextField.tintColor = UIColor.clearColor()
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.Default
        toolBar.translucent = true
        //toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Plain, target: self, action: "donePicker")
        let pickerTitle = UINavigationItem(title: "Choose an expiration window")
        let pickerTitle2 = UIBarButtonItem(title: "Choose an expiration window", style: UIBarButtonItemStyle.Plain, target: self, action: nil)
        //let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Plain, target: self, action: "donePicker")
        
        toolBar.setItems([cancelButton, pickerTitle2, doneButton], animated: false)
        toolBar.userInteractionEnabled = true
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        self.view.endEditing(true)
        return false
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // MARK: - (Re)Calculate expiration array
    func calculateExpired() {
        
        expiredIngredients.removeAll()
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
        
        //var calculatedDate = NSCalendar.currentCalendar().dateByAddingUnit(NSCalendarUnit.Day, value: 20, toDate: cellExpiryDate, options: NSCalendarOptions.init(rawValue: 0))
        
        //var diffDateComponents = NSCalendar.currentCalendar().components([NSCalendarUnit.Year, NSCalendarUnit.Month, NSCalendarUnit.Day, NSCalendarUnit.Hour, NSCalendarUnit.Minute, NSCalendarUnit.Second], fromDate: cellExpiryDate, toDate: currentDate, options: NSCalendarOptions.init(rawValue: 0))
        
        //Go through the original ingredient array and the copy. Remove all ingredients that aren't close to the set expiration date.
        for x in 0...ingredients.count - 1 {
            
            var arrayYValue = 0
            
            print("x")
            print(x)
            
            for y in 0...ingredients[x].count - 1 {
                
                //                print("y")
                //                print(y)
                //
                //                print("Ingredient.expiration")
                //                print(ingredients[x][y].expiry)
                //                print(ingredients[x][y].name)
                
                dateAsString = ingredients[x][y].expiry
                let cellExpiryDate = dateFormatter.dateFromString(dateAsString)!
                //diffDateComponents = NSCalendar.currentCalendar().components([NSCalendarUnit.Year, NSCalendarUnit.Month, NSCalendarUnit.Day, NSCalendarUnit.Hour, NSCalendarUnit.Minute, NSCalendarUnit.Second], fromDate: cellExpiryDate, toDate: currentDate, options: NSCalendarOptions.init(rawValue: 0))
                
                // Only remove if the expiration date is greater than the current date + offset
                
                let inExpiryWindow = cellExpiryDate.laterDate(currentDatePlusExpiryWindow!)
                let compareDates = inExpiryWindow.compare(cellExpiryDate)
                
                if inExpiryWindow == cellExpiryDate {
                    //if compareDates == NSComparisonResult.OrderedAscending {
                    
                    //let appendIngredientToExpiryArr = ingredients[x][arrayYValue]
                    
                    //print("exp ingred")
                    //print(expiredIngredients)
                    
                    //Use arrayYValue because the indexes will change after removing a value.
                    expiredIngredients[x].removeAtIndex(arrayYValue)
                    
                } else {
                    // This index is fine so increment the counter
                    print("no match")
                    arrayYValue += 1
                }
                
            }
            
        }
        
        //        print("exp ingred")
        //        print(expiredIngredients)
        //
        //        print("ingred")
        //        print(ingredients)
        
        
    }
    
    func calculateExpiredByDate() {
        
        expiredByDate.removeAll()
        
        let flatIngredients = expiredIngredients.flatMap { $0 }
        
        var dateCounter = 0
        for inExpired in 0...flatIngredients.count - 1 {
            if dateCounter == 0 {
                expiredByDate.append([flatIngredients[inExpired]])
                
            } else {
                if expiredByDate[dateCounter][0].expiry == flatIngredients[inExpired].expiry {
                    expiredByDate[dateCounter].append(flatIngredients[inExpired])
                } else {
                    expiredByDate.append([flatIngredients[inExpired]])
                    dateCounter += 1
                }
                
            }
            
        }
        
        expiredByDate = expiredByDate.sort({ $0[0].expiry < $1[0].expiry })
        
        print("Expired by date")
        print(expiredByDate)
        print(expiredByDate[0][0].expiry)
        print(expiredByDate[1][0].expiry)
        print(expiredByDate[2][0].expiry)
        
        
        print("Flattened")
        print(flatIngredients)
        
        expiryDates.removeAll()
        
        // Fill the expiration Dates array
        for inExpired in 0...flatIngredients.count - 1 {
            expiryDates += [flatIngredients[inExpired].expiry]
        }
        
        print("expiryDates")
        print(expiryDates.count)
        print(expiryDates[0])
        
        
        expiryDates = expiryDates.sort()
        
        
    }
    
    // MARK: - PickerView
    // The number of rows of data
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return expirationPickerData.count
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(expirationPickerData[row])
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
        
        //if changeViewButton.titleLabel!.text == "Date View" {
        if !isDateSeparatedTable {
            
            if myFridge.doorNames.count > 1 {
                return myFridge.doorNames.count
            } else {
                return 1
            }
        } else {
            return expiryDates.count
            
        }
        
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        //if changeViewButton.titleLabel!.text == "Date View" {
        if !isDateSeparatedTable {
            
            if  myFridge.doorNames.count > 1 {
                return myFridge.doorNames[section]
            } else {
                return nil
            }
            
        } else {
            return expiryDates[section]
        }
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //if tableView == self.searchDisplayController!.searchResultsTableView {
        
        //    return self.filteredIngredients.count
        
        //} else {
        
        //return self.ingredients.count
        
        //if changeViewButton.titleLabel!.text == "Date View" {
        if !isDateSeparatedTable {
            
            if self.ingredients[section].count != 0 {
                return self.expiredIngredients[section].count
            } else {
                return 0
            }
            
        } else {
            return expiredByDate[section].count
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "ExpirationListTableViewCell"
        
        let cell = self.expiryTableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! ExpireTableViewCell
        
        let ingredient: Ingredient
        
        let emptyCircle = UIImage(named: "Unselected")
        let filledCircle = UIImage(named: "Selected")
        
        // Fetches the appropriate meal for the data source layout.
        if !isDateSeparatedTable {
            ingredient = expiredIngredients[indexPath.section][indexPath.row]
        } else {
            ingredient = expiredByDate[indexPath.section][indexPath.row]
        }
        
        cell.selectedButton.setImage(emptyCircle, forState: .Normal)
        cell.selectedButton.setImage(filledCircle, forState: .Selected)
        cell.selectedButton.setImage(filledCircle, forState: [.Highlighted,.Selected])
        
        cell.selectedButton.adjustsImageWhenHighlighted = false

        if addToListButton.tag == 1 {
            cell.selectedButton.hidden = true
        } else {
            cell.selectedButton.hidden = false
            cell.selectedButton.selected = false
        }
        
        cell.expireFoodName?.text = ingredient.name
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
    
    func changeTable(refreshControl: UIRefreshControl) {
        
        isDateSeparatedTable = !isDateSeparatedTable
        
        self.expiryTableView.reloadData()
        self.expiryTableView.reloadSectionIndexTitles()
        self.expiryTableView.reloadInputViews()
        
        refreshControl.endRefreshing()
        
        if !isDateSeparatedTable {
            refreshControl.attributedTitle = NSAttributedString(string: "Change to Date View")
        } else {
            refreshControl.attributedTitle = NSAttributedString(string: "Change to Area View")
        }
        
    }
    
    @IBAction func changeTableTapped(sender: AnyObject) {
        
        changeTable(refreshControl)
        
        //        print("tapped")
        //        if changeViewButton.titleLabel!.text == "Date View" {
        //            changeViewButton.setTitle("Area View", forState: .Normal)
        //        } else {
        //            changeViewButton.setTitle("Date View", forState: .Normal)
        //        }
        //
        //        self.expiryTableView.reloadData()
        //        self.expiryTableView.reloadSectionIndexTitles()
        //        self.expiryTableView.reloadInputViews()
        //        self.view.setNeedsDisplay()
        //        self.expiryTableView.setNeedsDisplay()
        //        expiryTableView.setNeedsDisplay()
        //
        //
        //        dispatch_async(dispatch_get_main_queue(),{
        //            self.expiryTableView.reloadData()
        //            self.expiryTableView.reloadSectionIndexTitles()
        //            self.expiryTableView.reloadInputViews()
        //            self.view.setNeedsDisplay()
        //            self.expiryTableView.setNeedsDisplay()
        //
        //        })
        //
        
    }
    
    @IBAction func addToListTapped(sender: AnyObject) {
        
        if addToListButton.tag == 1 {
            addToListButton.title = "Add Selected"
            addToListButton.tag = 2
            changeViewButton.enabled = false
            selectedIngredients.removeAll()
            expiryTableView.reloadData()
        } else {
            
            changeViewButton.enabled = true
            addToListButton.tag = 1
            addToListButton.title = "Add to List"
            
            guard selectedIngredients.count > 0 else {
                print("guarded")
                expiryTableView.reloadData()
                return
            }
            
            let controller = self.storyboard?.instantiateViewControllerWithIdentifier("AddToListFromIngredientTab") as! AddToListFromIngredientDetailsViewController
            //controller.previousVC = "FoodsListTableViewController"
            //controller.selectedIngredient = ingredient.name
            controller.selectedIngredients = selectedIngredients
            controller.modalTransitionStyle = .CrossDissolve
            controller.modalPresentationStyle = .OverCurrentContext
            self.presentViewController(controller, animated: true, completion: nil)
            
            
            //            var lists = PersistManager.sharedManager.ShoppingLists.lists
            //            let listName = "Super 1 List"
            //            var toAddToList = lists[listName]
            //
            //            for ingredient in 0...selectedIngredients.count - 1 {
            //                let willAdd = selectedIngredients[ingredient]
            //                toAddToList?.append(willAdd)
            //            }
            //
            //            if toAddToList!.count > 0 {
            //                lists[listName] = toAddToList
            //            }
            //
            //            PersistManager.sharedManager.ShoppingLists.lists[listName] = lists[listName]
            //            let saveList = PersistenceHandler()
            //            saveList.save()
            
            expiryTableView.reloadData()
            
        }
        
    }
    
    @IBAction func wasSelected(sender: AnyObject) {
        
        //if selectedIngredients.count < 1 {
        //    addSelected.enabled = false
        //} else {
        //    addSelected.enabled = true
        //}
        
        let button = sender as! UIButton
        let cell = button.superview?.superview as! ExpireTableViewCell
        let sectionAndRow = expiryTableView.indexPathForCell(cell)
        let row = sectionAndRow?.row
        let section = sectionAndRow?.section
        
        print(row)
        print(button.selected)
        
        let name: String
        
        if !isDateSeparatedTable {
            name = expiredIngredients[section!][row!].name
        } else {
            name = expiredByDate[section!][row!].name
        }
        
        if button.selected == true {
            button.selected = false
            if selectedIngredients.contains(name) == true {
                let index = selectedIngredients.indexOf(name)
                selectedIngredients.removeAtIndex(index!)
            }
            print(selectedIngredients)
        } else {
            button.selected = true
            selectedIngredients.append(name)
            print(selectedIngredients)
        }
        
    }
    
    
}
