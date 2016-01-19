//
//  ListDetailAddExistingIngredient.swift
//  FridgeApp
//
//  Created by Chase Peers on 1/13/16.
//  Copyright © 2016 Chase Peers. All rights reserved.
//

import UIKit

class ListDetailAddExistingIngredient: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var existingIngredientTable: UITableView!
    @IBOutlet weak var addSelected: UIButton!
    
    var existingIngredients = PersistManager.sharedManager.Ingredients
    var myFridge = PersistManager.sharedManager.MyFridge
    
    var selectedIngredients = [""]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        selectedIngredients.removeFirst()
        
        existingIngredientTable.delegate = self
        existingIngredientTable.dataSource = self
        
        addSelected.enabled = false
        
        print("Add from existing")
        print(myFridge.doorNames)
        print(existingIngredients.count)
        
    }
        
    @IBAction func cancel(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    /*
    // MARK: - TableView
    */
    
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
        
        if self.existingIngredients[section].count != 0 {
            return self.existingIngredients[section].count
        } else {
            return 0
        }
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "ListDetailAddExistingIngredientCell"
        
        let cell = self.existingIngredientTable.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! ListDetailAddExistingIngredientCell
        
        let ingredient : Ingredient
        ingredient = existingIngredients[indexPath.section][indexPath.row]
        
        let emptyCircle = UIImage(named: "Unselected")
        let filledCircle = UIImage(named: "Selected")
        
        //cell.selectedButton.setTitleColor(UIColor.blackColor(), forState: [.Normal,.Selected,.Highlighted])
        //cell.selectedButton.setTitle("", forState: UIControlState.Normal)
        cell.selectedButton.setImage(emptyCircle, forState: .Normal)
        cell.selectedButton.setImage(filledCircle, forState: .Selected)
        cell.selectedButton.setImage(filledCircle, forState: [.Highlighted,.Selected])
        
        cell.selectedButton.adjustsImageWhenHighlighted = false
        
        
        cell.existingIngredientImage.image = ingredient.image
        cell.existingIngredientName.text = ingredient.name
        
        cell.selectedButton.tag = indexPath.section * 1000 + indexPath.row
        
        print(cell.selectedButton.tag)
        //cell.selectedButton.addTarget(self, action: "wasSelected:", forControlEvents: .TouchUpInside)
        //cell.selectedButton.addTarget(self, action: "a:", forControlEvents: .TouchDown)
        return cell
        
    }
    

    @IBAction func wasSelected(sender: AnyObject) {
        
        //if selectedIngredients.count < 1 {
        //    addSelected.enabled = false
        //} else {
        //    addSelected.enabled = true
        //}
        
        let button = sender as! UIButton
        let cell = button.superview?.superview as! ListDetailAddExistingIngredientCell
        let sectionAndRow = existingIngredientTable.indexPathForCell(cell)
        let section = sectionAndRow?.section
        let row = sectionAndRow?.row
        
        print(row)
        print(section)
        print(button.selected)
        
        let name = existingIngredients[section!][row!].name
        
        if button.selected == true {
            button.selected = false
            if selectedIngredients.contains(name) == true {
                let index = selectedIngredients.indexOf(name)
                selectedIngredients.removeAtIndex(index!)
            }
            print(selectedIngredients)
        } else {
            button.selected = true
            selectedIngredients.append(existingIngredients[section!][row!].name)
            print(selectedIngredients)
        }
        
        addSelected.enabled = !selectedIngredients.isEmpty
        
    }
}
