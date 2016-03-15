//
//  FinishedShopping.swift
//  FridgeApp
//
//  Created by Chase Peers on 1/20/16.
//  Copyright © 2016 Chase Peers. All rights reserved.
//

import UIKit

class FinishedShoppingViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var foregroundView: UIView!
    @IBOutlet weak var locationText: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var addRemainingButton: UIButton!
    
    var locationPickerData: [String] = [String]()
    var fridgeAreaTextFieldOriginalText = ""
    
    var selectedFromList: [String] = []
    
    var myFridge: FridgeInfo!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myFridge = PersistManager.sharedManager.MyFridge
        locationPickerData = myFridge.doorNames
        
        // Handle the text field’s user input through delegate callbacks.
        locationText.delegate = self
        
        // Make it look like the view is on top of the previous view
        //view.backgroundColor = UIColor.whiteColor()
        
        self.view.backgroundColor = UIColor(white: 0, alpha: 0.4)
        
        // Round corners and shadows
        foregroundView.layer.cornerRadius = 8
        
        foregroundView.layer.masksToBounds = true
        
        foregroundView.layer.borderColor = UIColor.grayColor().CGColor
        foregroundView.layer.borderWidth = 0.5
        
        foregroundView.layer.shadowColor = UIColor.blackColor().CGColor
        foregroundView.layer.shadowOffset = CGSizeZero
        foregroundView.layer.shadowRadius = 5.0
        foregroundView.layer.shadowOpacity = 0.5
        foregroundView.layer.masksToBounds = false
        foregroundView.clipsToBounds = false

        addRemainingButton.enabled = false
        nextButton.enabled = false
    
        lastOnListCheck()
        
    }
    
    @IBAction func cancel(sender: AnyObject) {
        //dismissViewControllerAnimated(true, completion: nil)
        self.performSegueWithIdentifier("ChooseLocation", sender: self)
        
    }
    
    // MARK: Picker
    // The number of columns of data
    @IBAction func locationBeingChosen(sender: UITextField) {
        
        addRemainingButton.enabled = false
        nextButton.enabled = false
        
        fridgeAreaTextFieldOriginalText = locationText.text!
        
        let locationPicker = UIPickerView()
        
        // Connect data:
        locationPicker.delegate = self
        locationPicker.dataSource = self
        
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.Default
        toolBar.translucent = true
        //toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Plain, target: self, action: "pickedLocation")
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Plain, target: self, action: "cancelLocationPicker")
        
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.userInteractionEnabled = true
        
        locationText.inputAccessoryView = toolBar
        
//        // Set picker to the location set in the ingredient location value... If it exists.
//        if ((ingredient?.location) != nil) {
//            let setrow = locationPickerData.indexOf((ingredient!.location))!
//            print("setrow")
//            print(setrow)
//            locationPicker.selectRow(setrow, inComponent: 0, animated: true)
//        } else if fridgeAreaTextFieldOriginalText != "" {
//            let setrow = locationPickerData.indexOf(fridgeAreaTextFieldOriginalText)
//            locationPicker.selectRow(setrow!, inComponent: 0, animated: true)
//        }
        
        sender.inputView = locationPicker
        
        locationText.text = locationPickerData[locationPicker.selectedRowInComponent(0)]
        
    }
    
    func cancelLocationPicker() {
        
        locationText.text! = fridgeAreaTextFieldOriginalText
        locationText.resignFirstResponder()
        fridgeAreaTextFieldOriginalText = ""
        
    }
    
    func pickedLocation() {
        locationText.resignFirstResponder()
        
        enableDisableButtons()

    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
            return 1
    }
    
    // The number of rows of data
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return locationPickerData.count
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return locationPickerData[row]
    }
    
    // Catpure the picker view selection
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // This method is triggered whenever the user makes a change to the picker selection.
        // The parameter named row and component represents what was selected.
        
        locationText.text = locationPickerData[row]
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
        
        enableDisableButtons()

    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        self.view.endEditing(true)
        
        enableDisableButtons()
        
        return true
    }
    
    func enableDisableButtons() {
        
        if addRemainingButton.enabled == true {
            addRemainingButton.enabled = false
            nextButton.enabled = false
        } else {
            addRemainingButton.enabled = true
            nextButton.enabled = true
        }
    
        lastOnListCheck()
    
    }
    
    func lastOnListCheck() {
        
        if selectedFromList.count == 1 {
            self.nextButton.setTitle("Finish", forState: .Normal)
            self.addRemainingButton.enabled = false
        }
        
    }
    
    @IBAction func addRemainingButtonAction(sender: UIButton) {
        
        for _ in selectedFromList {
            let toBeAdded = selectedFromList.removeFirst()
            addIngredient(toBeAdded)
        }
        
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    @IBAction func nextButtonAction(sender: UIButton) {
        
        if selectedFromList.count > 0 {
            
            let toBeAdded = selectedFromList.removeFirst()
            addIngredient(toBeAdded)
            
        }
        
        if selectedFromList.count == 0 {
            dismissViewControllerAnimated(true, completion: nil)
        }
        
        lastOnListCheck()
        
    }
    
    func addIngredient(ingredientToBeAdded: String) {
        
        var ingredients = PersistManager.sharedManager.Ingredients
        
        let addIngredient = Ingredient(name: ingredientToBeAdded, image: nil, expiry: "", amount: 0.0, location: locationText.text!)!
        
        let location = locationPickerData.indexOf(locationText.text!)
        
        if ingredients[location!].count > 0 {
            //ingredients[location!].insert(addIngredient, atIndex: ingredients[location!].count - 1)
            ingredients[location!].append(addIngredient)
        } else {
            ingredients[location!].insert(addIngredient, atIndex: 0)
        }
        
        
        PersistManager.sharedManager.Ingredients = ingredients
        let saveList = PersistenceHandler()
        saveList.save()
        
        if selectedFromList.count < 1 {
            self.performSegueWithIdentifier("ChooseLocation", sender: self)
        }

        
    }
    
}
