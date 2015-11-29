//
//  NewIngredientViewController.swift
//  FridgeApp
//
//  Created by Chase Peers on 10/15/15.
//  Copyright © 2015 Chase Peers. All rights reserved.
//

import UIKit

class NewIngredientViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var AddIngredientButton: UIBarButtonItem!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var expirationTextField: UITextField!
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var locationPicker: UIPickerView!

    var MyFridge: FridgeInfo?
    var MyFridge2: FridgeInfo?
    
    var ingredient: Ingredient?
    
    var locationPickerData: [String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let FTBC = self.tabBarController as! FridgeTabBarController
        
        MyFridge = FTBC.MyFridge
        print("check data")
        print(MyFridge?.doorNames)
        print(MyFridge?.numOfDoors)
        print(MyFridge?.fridgeName)
        
        //let FFVC = FridgeViewController
        //MyFridge2 = FFVC.MyFridge
        
        print(MyFridge2?.doorNames)
        
        // Handle the text field’s user input through delegate callbacks.
        nameTextField.delegate = self
        
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
            //locationPicker.selectedRowInComponent(<#T##component: Int##Int#>) = ingredient.location???
            
            //let row2 = locationPickerData.indexOf(ingredient.location)
            //let row3 = locationPickerData.

            //print("row2")
            //print(row2)
        }
        
        // Connect data:
        self.locationPicker.delegate = self
        self.locationPicker.dataSource = self
        
        // Input data into the Array:
        locationPickerData = (MyFridge?.doorNames)!
        print(MyFridge?.doorNames)
        
        checkValidIngredientName()
        
        print("location")
        print(ingredient?.location)
        
        var setrow: Int
        
        setrow = locationPickerData.indexOf((ingredient?.location)!)!
        print("setrow")
        print(setrow)
        
        locationPicker.selectRow(setrow, inComponent: 0, animated: true)

        
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
    
    // MARK: Picker
    // The number of columns of data
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
        
        ingredient?.location = locationPickerData[row]
    }
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        checkValidIngredientName()
        navigationItem.title = textField.text
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        // Disable the Save button while editing.
        AddIngredientButton.enabled = false
    }
    
    func checkValidIngredientName() {
        // Disable the Save button if the text field is empty.
        let text = nameTextField.text ?? ""
        AddIngredientButton.enabled = !text.isEmpty
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
            
            let row = locationPicker.selectedRowInComponent(0)
            let location = locationPickerData[row]
            print("row")
            print(row)
            print("location")
            print(location)
            
            ingredient = Ingredient(name: name, image: nil, expiry: expiry, amount: amount, location: location)
        }
    }

}
