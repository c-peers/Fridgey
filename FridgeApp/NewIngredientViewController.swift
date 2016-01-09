    //
//  NewIngredientViewController.swift
//  FridgeApp
//
//  Created by Chase Peers on 10/15/15.
//  Copyright © 2015 Chase Peers. All rights reserved.
//

import UIKit

class NewIngredientViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var AddIngredientButton: UIBarButtonItem!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var expirationTextField: UITextField!
    @IBOutlet weak var amountTextField: UITextField!
    //@IBOutlet weak var amountTextField: UITextField!
    //@IBOutlet weak var locationPicker: UIPickerView!
    //@IBOutlet weak var expirationPicker: UIDatePicker!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var addtolistButton: UIButton!
    @IBOutlet weak var test: UITextField!

    @IBOutlet weak var autocompleteTableView: UITableView!
    //let autocompleteTableView = UITableView(frame: UIScreen.mainScreen().bounds, style: UITableViewStyle.Plain)
    
    var MyFridge: FridgeInfo?
    var MyFridge2: FridgeInfo?
    
    var ingredient: Ingredient?
    
    var mainList: Lists?
    
    var locationPickerData: [String] = [String]()
    
    //var ingredientNameChoices = ["Carrot", "Apple", "Chicken", "Hot Dog", "Steak", "Celery", "Yam", "Eggs"]
    var ingredientNameChoices = ["Initial", "Values"]
    
    var autocompleteDisplay = [String]()
 
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Load food name list from text file.
        //var filePathURL: String
        let readFile: String
        
        if let filePath = NSBundle.mainBundle().pathForResource("FoodNames", ofType: "txt") {
            //filePathURL = String(NSURL.fileURLWithPath(filePath))
            try! readFile = String(contentsOfFile: filePath, encoding: NSUTF8StringEncoding)
            ingredientNameChoices = readFile.componentsSeparatedByCharactersInSet(NSCharacterSet.newlineCharacterSet())
        } else {
            // If the file isn't there then there isn't much I can do except forgo the function.
            print("There was an error")
            readFile = ""
        }

        //let documentsPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
        //let destinationPath:NSString = documentsPath.stringByAppendingString("/FoodNames.txt")
        //try! readFile = String(contentsOfFile: filePathURL as String, encoding: NSUTF8StringEncoding)
        
        //ingredientNameChoices = readFile.componentsSeparatedByCharactersInSet(NSCharacterSet.newlineCharacterSet())
        
        print(ingredientNameChoices)

        // Handle the text field’s user input through delegate callbacks.
        nameTextField.delegate = self
        expirationTextField.delegate = self
        //amountTextField.delegate = self
        //test.delegate = self
        
        amountTextField.keyboardType = .NumberPad
        
        // Set up views if editing an existing Meal.
        if let ingredient = ingredient {
            // Update title and change add -> edit
            navigationItem.title = ingredient.name
            AddIngredientButton.title = "Edit"

            // Populate fields with existing data
            nameTextField.text   = ingredient.name
            //photoImageView.image = ingredient.image
            amountTextField.text = ingredient.amount.description
            expirationTextField.text = ingredient.expiry
            locationTextField.text = ingredient.location
        }
        
        print("autocomplete stuff")
        autocompleteTableView.delegate = self
        autocompleteTableView.dataSource = self
        autocompleteTableView.scrollEnabled = true
        //autocompleteTableView.frame = CGRectMake(100, 100, 100, 100)
        autocompleteTableView.alpha = 0
        
        print("AC Cell")
        autocompleteTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "AutoCompleteRowIdentifier")
        
        print("Add subview")
        self.view.addSubview(autocompleteTableView)
        
        // Input data into the Array:
        //locationPickerData = (MyFridge?.doorNames)!
        //print(MyFridge?.doorNames)
        
        checkValidIngredientName()
        
        print("location")
        print(ingredient?.location)
        
        // Set picker to the location set in the ingredient location value... If it exists.
//        if ((ingredient?.location) != nil) {
//            setrow = locationPickerData.indexOf((ingredient!.location))!
//            print("setrow")
//            print(setrow)
//            locationPicker.selectRow(setrow, inComponent: 0, animated: true)
//        }
        

        
    }
    
//    func viewDidAppear() {
//
//        var setrow: Int
//        
//        setrow = locationPickerData.indexOf((ingredient?.location)!)!
//        print("setrow")
//        print(setrow)
//        
//        locationPicker.selectRow(setrow, inComponent: 0, animated: true)
//
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Text Autocomplete
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString
        string: String) -> Bool {
        
            // Only run for the food name if the cadidate list file was loaded.
            if textField == nameTextField && ingredientNameChoices.count > 2 {
                print("change chars")
                UIView.animateWithDuration(0.5, animations: {
                    self.autocompleteTableView.alpha = 1.0
                })
                let str = nameTextField.text
                self.search(str!)
                return true

            } else {
                return false
            }
        
    }
    
    func search(subString: String) {
        autocompleteDisplay.removeAll(keepCapacity: false)
        print("AC search")
        
        for curString in ingredientNameChoices
        {
            let myString:NSString! = curString as NSString
            
            let subStringRange :NSRange! = myString.rangeOfString(subString)
            
            if (subStringRange.location  == 0)
            {
                autocompleteDisplay.append(curString)
            }
        }
        
        autocompleteTableView.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return autocompleteDisplay.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let autoCompleteRowIdentifier = "AutoCompleteRowIdentifier"
        let cell : UITableViewCell = tableView.dequeueReusableCellWithIdentifier(autoCompleteRowIdentifier, forIndexPath: indexPath) as UITableViewCell
        
        let index = indexPath.row as Int
        cell.textLabel!.text = autocompleteDisplay[index]
        cell.textLabel!.font = UIFont(name: cell.textLabel!.font.fontName, size: 14)
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let selectedCell : UITableViewCell = tableView.cellForRowAtIndexPath(indexPath)!
        nameTextField.text = selectedCell.textLabel!.text
        UIView.animateWithDuration(0.5, animations: {
            self.autocompleteTableView.alpha = 0
        })
        
    }
    
    // MARK: DatePicker
    // Action for popping up DatePicker
    @IBAction func expirationDateBeingChosen(sender: UITextField) {

        let datePicker = UIDatePicker()
        datePicker.tag = 1
        datePicker.datePickerMode = UIDatePickerMode.Date
        sender.inputView = datePicker
        //datePicker.addTarget(self, action: Selector("datePickerValueChanged:"), forControlEvents: UIControlEvents.ValueChanged)
        datePicker.addTarget(self, action: Selector("expirationDatePicked:"), forControlEvents: UIControlEvents.ValueChanged)
        
    }
    
    // Set time format and put date in text view
    func expirationDatePicked(sender: UIDatePicker) {
        
        let timeFormat = NSDateFormatter()
        //timeFormat.dateStyle = .ShortStyle
        timeFormat.dateFormat = "YYYY-MM-dd"
        print(timeFormat.stringFromDate(sender.date))
        expirationTextField.text = timeFormat.stringFromDate(sender.date)
        
    }
    
    // MARK: Picker
    // The number of columns of data
    @IBAction func locationBeingChosen(sender: UITextField) {

        let locationPicker = UIPickerView()
        locationPicker.tag = 2
        
        // Connect data:
        locationPicker.delegate = self
        locationPicker.dataSource = self
        
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.Default
        toolBar.translucent = true
        //toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Plain, target: self, action: "donePicker")
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Plain, target: self, action: "donePicker")
        
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.userInteractionEnabled = true
        
        locationTextField.inputAccessoryView = toolBar
        
        // Set picker to the location set in the ingredient location value... If it exists.
        if ((ingredient?.location) != nil) {
            let setrow = locationPickerData.indexOf((ingredient!.location))!
            print("setrow")
            print(setrow)
            locationPicker.selectRow(setrow, inComponent: 0, animated: true)
        }

        sender.inputView = locationPicker
        
        locationTextField.text = locationPickerData[locationPicker.selectedRowInComponent(0)]
        
    }
    
    func donePicker() {
        
        locationTextField.resignFirstResponder()
        
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        if pickerView.tag == 2 {
            return 1
        } else {
         return 0
        }
    }
    
    // The number of rows of data
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 2 {
            return locationPickerData.count
        } else {
            return 1
        }
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 2 {
            return locationPickerData[row]
        } else {
            return "Blank"
        }
        
    }
    
    // Catpure the picker view selection
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // This method is triggered whenever the user makes a change to the picker selection.
        // The parameter named row and component represents what was selected.
        
            ingredient?.location = locationPickerData[row]
            locationTextField.text = locationPickerData[row]
            checkValidIngredientName()
            
    }
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        return true
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
    
    func textFieldDidEndEditing(textField: UITextField) {
        checkValidIngredientName()
        if textField == nameTextField {
            navigationItem.title = textField.text
        }
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        // Disable the Save button while editing.
        AddIngredientButton.enabled = false
    }
    
    func checkValidIngredientName() {
        // Disable the Save button if the text field is empty.
        let nameText = nameTextField.text ?? ""
        let locationText = locationTextField.text ?? ""
        
        AddIngredientButton.enabled = !nameText.isEmpty && !locationText.isEmpty
    }
    
    
    // MARK: Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if AddIngredientButton == (sender as? UIBarButtonItem) {
            let name = nameTextField.text!
            //let image =
            let expiry = expirationTextField.text!
            //let amount = amountTextField.text
            
            let numberToFloat = NSNumberFormatter()
            let number = numberToFloat.numberFromString(amountTextField.text!)
            let amount = number!.floatValue
            
            //let row = locationPicker.selectedRowInComponent(0)
            let location = locationTextField.text
            
            ingredient = Ingredient(name: name, image: nil, expiry: expiry, amount: amount, location: location!)
        } else if addtolistButton == (sender as? UIButton) {
            
            print("addtolistbutton?")
            
            let addtolistViewController = segue.destinationViewController as! AddToListFromIngredientDetailsViewController
            
            addtolistViewController.selectedIngredient = nameTextField.text!
            addtolistViewController.mainList = mainList!
            
        }
    }

    @IBAction func cancelAction(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    @IBAction func unwindToNewIngredient(sender: UIStoryboardSegue) {
        
        if let addToListFromIngredientDetailsViewController = sender.sourceViewController as? AddToListFromIngredientDetailsViewController {
            
            let selectedList = addToListFromIngredientDetailsViewController.selectedList
            
            let selectedListDetails = addToListFromIngredientDetailsViewController.mainList.lists[selectedList]

            print(selectedList)
            print(selectedListDetails)
            
            PersistManager.sharedManager.ShoppingLists.lists[selectedList] = selectedListDetails
            
            // Save lists
            PersistManager.sharedManager.saveList()
            
        }
        
    }

    
}
